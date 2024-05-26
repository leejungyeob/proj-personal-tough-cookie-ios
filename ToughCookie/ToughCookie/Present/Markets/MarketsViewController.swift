//
//  MarketsViewController.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/15/24.
//

import UIKit
import RxSwift
import RxCocoa

class MarketsViewController: BaseViewController<MarketsView> {
    
    var viewModel: MarketsViewModel
    
    private var dataSource: UITableViewDiffableDataSource<TickerSection, TickerPresentData>!
    
    init(viewModel: MarketsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func configureView() {
        
        layoutView.tableView.delegate = self
        layoutView.tableView.register(MarketsTableViewCell.self, forCellReuseIdentifier: "cell")
        layoutView.tableView.register(TickerMainSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        
        layoutView.tableView.sectionHeaderTopPadding = 0
        
        let header = MarketsHeaderView()
        header.backgroundColor = .subBlue
        header.searchBar.delegate = self
        header.searchBar.searchTextField.delegate = self
        header.searchBar.enablesReturnKeyAutomatically = false
        
        layoutView.tableView.tableHeaderView = header
        
        // NotificationCenter.default.addObserver(self, selector: #selector(applicationBecome), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        // background -> foreground : tableViewCell 다시 그리기 및 소켓 재연결
        SceneDelegate.detectedEnterForeground = { [weak self] in
            
            guard let self else { return }
            
            self.layoutView.tableView.reloadData()
            self.viewModel.connect()
        }
    }
    
    override func configureTableView() {
        
        self.dataSource = UITableViewDiffableDataSource(tableView: layoutView.tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            
            guard let cell: MarketsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MarketsTableViewCell else { return UITableViewCell() }
            
            cell.configureView(itemIdentifier)
            cell.updateSign(itemIdentifier)
            
            cell.layoutSubviews()
            
            return cell
        })
        
        self.dataSource.defaultRowAnimation = .none
    }
    
    override func bind() {
        
        self.rx.viewWillAppearObservable
            .subscribe(with: self) { owner, _ in
                
                owner.viewModel.connect()
            }.disposed(by: disposeBag)
        
        let output = viewModel.transform(viewModel.input)
        
        // RxDataSource 연결
        output.sortedTickerPresentDataDriver
            .drive(with: self) { owner, data in
                
                var snapshot = NSDiffableDataSourceSnapshot<TickerSection, TickerPresentData>()
                
                snapshot.appendSections([TickerSection.main])
                
                snapshot.appendItems(data, toSection: .main)
                
                owner.dataSource.apply(snapshot, animatingDifferences: false)
                
            }.disposed(by: disposeBag)
        
        output.languageTypeDriver
            .drive(with: self) { owner, _ in
                
                owner.layoutView.tableView.reloadData()
                
            }.disposed(by: disposeBag)
        
        output.sortedTypeDriver
            .drive(with: self) { owner, _ in
                
                owner.layoutView.tableView.reloadData()
                
            }.disposed(by: disposeBag)
    }
}


extension MarketsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let tickerPresentData = self.dataSource.itemIdentifier(for: indexPath) else { return }
        
        self.viewModel.input.cellSelectedRelay.accept(tickerPresentData)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let section = TickerSection(rawValue: section) else { return nil }
        
        switch section {
        case .main:
            
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? TickerMainSectionHeaderView else { return nil }
            
            // 타이틀 언어 변경
            header.titleLanguageButton.rx.tap
                .subscribe(with: self) { owner, _ in
                    
                    owner.viewModel.input.languageTypeRelay.accept(())
                    header.updateTitleLanguage()
                }.disposed(by: header.disposeBag)
            
            // 현재가 정렬
            header.tradePriceButton.rx.tap
                .subscribe(with: self) { owner, _ in
                    
                    owner.viewModel.input.sortedTypeRelay.accept(.tradePrice)
                    header.updateSortedType()
                }.disposed(by: header.disposeBag)
            
            // 전일대비 정렬
            header.changeButton.rx.tap
                .subscribe(with: self) { owner, _ in
                    
                    owner.viewModel.input.sortedTypeRelay.accept(.change)
                    header.updateSortedType()
                }.disposed(by: header.disposeBag)
            
            // 거래대금 정렬
            header.accTradePriceButton.rx.tap
                .subscribe(with: self) { owner, _ in
                    
                    owner.viewModel.input.sortedTypeRelay.accept(.accTradePrice)
                    header.updateSortedType()
                }.disposed(by: header.disposeBag)
            
            
            return header
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        self.layoutView.endEditing(true)
    }
}

extension MarketsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.layoutView.endEditing(true)
        
        return true
    }
}

extension MarketsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        CoinRepository.shared.searchFilter = searchText == "" ? nil : searchText
    }
}
