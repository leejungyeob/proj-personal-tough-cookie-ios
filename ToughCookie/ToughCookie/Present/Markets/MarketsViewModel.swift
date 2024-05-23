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
    
    var coordinator: Coordinator?
    var repository: CoinRepository = CoinRepository.shared
    let sortedTickerPresentData = PublishRelay<[TickerPresentData]>()
    
    var disposeBag = DisposeBag()
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    struct Input { }
    
    struct Output {
        
        let sortedTickerPresentDataDriver: Driver<[TickerPresentData]>
    }
    
    func transform(_ input: Input) -> Output {
        
        let sortedTickerPresentDataDriver = sortedTickerPresentData
            .throttle(.milliseconds(200), scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: [TickerPresentData.dummyData()])
            
        
        return Output(sortedTickerPresentDataDriver: sortedTickerPresentDataDriver)
    }
    
    func connect() {
        
        let codes = repository.marketData.map { return $0.market }
        let socket = WebSocketManager.shared.connect() // 웹소켓 연결
        
        socket.onEvent = { [weak self] event in
            
            guard let self else { return }
            
            switch event {
                
                // 데이터 요청
            case .connected(_):
                
                WebSocketManager.shared.send("""
                      [{"ticket":"test"},{"type":"ticker","codes": \(codes)}]
                    """)
                
                // 데이터 수신
            case .binary(let data):
                
                guard let tickerData: TickerData = try? JSONDecoder().decode(TickerData.self, from: data) else { return }
                
                let tickerPresentData = tickerData.transformToTickerPresentData()
                // Ticker Data 저장(업데이트)
                self.repository.updateTickerDict(tickerPresentData)
                
                // 정렬된 Ticker Data 생성
                let sortedTickerPresentData = self.repository.sortedTickerList()
                
                self.sortedTickerPresentData.accept(sortedTickerPresentData)
                
            default: return
            }
        }
    }
}
