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
    
    var repository: CoinRepository = CoinRepository.shared
    
    let tickerDataRelay = PublishRelay<[TickerData]>()
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input) -> Output {
        
        
        
        return Output()
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
                
                // Ticker Data 저장(업데이트)
                repository.updateTickerDict(tickerData)
                
                // 정렬된 Ticker Data 전달
                let sortedTickerData = repository.sortedTickerList()
                
                self.tickerDataRelay.accept(sortedTickerData)
                
            default: return
            }
        }
    }
}
