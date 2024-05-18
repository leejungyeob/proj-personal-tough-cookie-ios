//
//  LaunchViewModel.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/18/24.
//

import Foundation
import RxSwift
import RxCocoa

final class LaunchViewModel: ViewModelProtocol {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    struct Input {
        
        let fetchMarketAll = PublishRelay<Void>()
    }
    
    struct Output {
        
        let marketAllDatas: Driver<[FetchMarketAllData]>
        let fetchFailure: Driver<UpbitAPIError>
    }
    
    func transform(_ input: Input) -> Output {
        
        let marketAllDatas = PublishRelay<[FetchMarketAllData]>()
        let fetchFailure = PublishRelay<UpbitAPIError>()
        
        input.fetchMarketAll.flatMap { _ in
            
            return APIManager.callAPI(router: UpbitRouter.fetchMarketAll, dataModel: [FetchMarketAllData].self)
        }.subscribe(with: self) { owner, result in
            
            switch result {
                
            case .success(let data):
                
                marketAllDatas.accept(data)
            case .failure(let error):
                
                fetchFailure.accept(error)
            }
        }.disposed(by: disposeBag)
        
        return Output(marketAllDatas: marketAllDatas.asDriver(onErrorJustReturn: []),
                      fetchFailure: fetchFailure.asDriver(onErrorJustReturn: .fail))
    }
}
