//
//  MarketsViewModel.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/19/24.
//

import Foundation
import RxSwift
import RxCocoa

final class MarketsViewModel: ViewModelProtocol {
    
    var disposeBag = DisposeBag()
    
    var coordinator: Coordinator?
    
    var marketAllData: [FetchMarketAllData]
    
    init(coordinator: Coordinator, data marketAllData: [FetchMarketAllData]) {
        self.coordinator = coordinator
        self.marketAllData = marketAllData
    }
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input) -> Output {
        
        return Output()
    }
}
