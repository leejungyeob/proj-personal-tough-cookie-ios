//
//  CoinViewModel.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/26/24.
//

import Foundation
import RxSwift
import RxCocoa

final class CoinViewModel: ViewModelProtocol {
    
    var coordinator: Coordinator
    var tickerPresentData: TickerPresentData
    
    var repository: CoinRepository = CoinRepository.shared
    
    let input = Input()
    
    var disposeBag = DisposeBag()
    
    struct Input { }
    
    struct Output { }
    
    init(coordinator: Coordinator, tickerPresentData: TickerPresentData) {
        self.coordinator = coordinator
        self.tickerPresentData = tickerPresentData
    }
    
    func transform(_ input: Input) -> Output {
        
        return Output()
    }
    
    func connect() {
        
        let codes = [tickerPresentData.code]
        let socket = WebSocketManager.shared.connect() // 웹소켓 연결
        
        socket.onEvent = { [weak self] event in
            
            guard let self else { return }
            
            switch event {
                
                // 데이터 요청
            case .connected(_):
                
                WebSocketManager.shared.send("""
                      [{"ticket":"test"},{"type":"orderbook","codes": \(codes)}]
                    """)
                
                // 데이터 수신
            case .binary(let data):
                
                guard let orderBookData: OrderBookData = try? JSONDecoder().decode(OrderBookData.self, from: data) else { return }
                
                
                
            default: return
            }
        }
    }
    
    func disconnect() {
        WebSocketManager.shared.disconnect()
    }
}
