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
    
    var coordinator: LaunchCoordinator?
    
    struct Input {
        
        let fetchMarketAll = PublishRelay<Void>()
    }
    
    struct Output {
        
        /// 업비트 API 조회 실패
        let fetchFailure: Driver<UpbitAPIError>
    }
    
    func transform(_ input: Input) -> Output {
        
        let fetchFailure = PublishRelay<UpbitAPIError>()
        
        // Fetch Market All Datas - 업비트에서 거래 가능한 마켓 목록
        input.fetchMarketAll.flatMap { _ in
            
            return APIManager.callAPI(router: UpbitRouter.fetchMarketAll, dataModel: [FetchMarketAllData].self)
        }.subscribe(with: self) { owner, result in
            
            switch result {
                
            case .success(let data):
                
                owner.coordinator?.marketAllData = data
                
            case .failure(let error):
                
                fetchFailure.accept(error)
            }
        }.disposed(by: disposeBag)
        
        return Output(fetchFailure: fetchFailure.asDriver(onErrorJustReturn: .fail))
    }
}
