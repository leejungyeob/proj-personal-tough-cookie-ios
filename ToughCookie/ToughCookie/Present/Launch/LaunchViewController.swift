//
//  LaunchViewController.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/18/24.
//

import UIKit
import RxSwift
import RxCocoa

class LaunchViewController: BaseViewController<LaunchView> {

    var viewModel: LaunchViewModel
    
    init(viewModel: LaunchViewModel) {
        
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureView() {
        layoutView.indicator.startAnimating()
    }
    
    override func bind() {
        
        let input = LaunchViewModel.Input()
        let output = viewModel.transform(input)
        
        // API Error
        output.fetchFailure.drive(with: self) { owner, error in
            
        }.disposed(by: disposeBag)
        
        input.fetchMarketAll.accept(())
    }
}
