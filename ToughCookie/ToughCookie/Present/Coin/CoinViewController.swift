//
//  CoinViewController.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/26/24.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa

class CoinViewController: UIHostingController<CoinView> {
    
    let disposeBag = DisposeBag()
    let viewModel: CoinViewModel
    
    init(rootView: CoinView, viewModel: CoinViewModel) {
        self.viewModel = viewModel
        
        super.init(rootView: rootView)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    func bind() {
        
        // Coin VC -> 재연결
        self.rx.viewWillAppearObservable
            .subscribe(with: self) { owner, _ in
                
                owner.viewModel.connect()
                
            }.disposed(by: disposeBag)
        
        // WebSocket 연결 해제
        self.rx.viewWillDisappearObservable
            .subscribe(with: self) { owner, _ in
                
                owner.viewModel.disconnect()
                
            }.disposed(by: disposeBag)
    }
}
