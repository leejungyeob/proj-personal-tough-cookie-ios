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
    
    private var dataSource: UITableViewDiffableDataSource<TickerMySection, TickerPresentData>!
    
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
    
    override func configureView() {
        
        layoutView.tableView.delegate = self
        layoutView.tableView.register(MarketsTableViewCell.self, forCellReuseIdentifier: "cell")
        
        let header = MarketsHeaderView()
        header.backgroundColor = .subBlue
        
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
        
        viewModel.connect()
        
        let input = MarketsViewModel.Input()
        let output = viewModel.transform(input)
        
        // RxDataSource 연결
        output.sortedTickerPresentDataDriver
            .drive(with: self) { owner, data in
                
                var snapshot = NSDiffableDataSourceSnapshot<TickerMySection, TickerPresentData>()
                
                snapshot.appendSections([TickerMySection.main])
                
                snapshot.appendItems(data, toSection: .main)
                
                owner.dataSource.apply(snapshot, animatingDifferences: false)
                
            }.disposed(by: disposeBag)
    }
}


extension MarketsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}
