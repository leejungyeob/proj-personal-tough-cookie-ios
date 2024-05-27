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
    let tickerPresentData: TickerPresentData
    
    init(rootView: CoinView, tickerPresentData: TickerPresentData) {
        
        self.tickerPresentData = tickerPresentData
        
        super.init(rootView: rootView)
    }
    
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = CoinRepository.shared.getMarketDatumByTickerPresentData(tickerPresentData).koreanName
    }
}
