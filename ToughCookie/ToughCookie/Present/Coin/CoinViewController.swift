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
    
    override init(rootView: CoinView) {
        super.init(rootView: rootView)
    }
    
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    func bind() {
        
        // WebSocket 연결 해제
        self.rx.viewWillDisappearObservable
            .subscribe(with: self) { owner, _ in
                
                owner.rootView.viewModel.disconnect()
                
            }.disposed(by: disposeBag)
    }
}
