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
        
        let sendData = PublishRelay<Void>()
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input) -> Output {
        
        return Output()
    }
    
    func connect() {
        
        let codes = marketAllData.map { return $0.market }
        let socket = WebSocketManager.shared.connect() // 웹소켓 연결
        
        socket.onEvent = { [weak self] event in
            
            switch event {
            // 데이터 요청
            case .connected(_):
            
                WebSocketManager.shared.send("""
                      [{"ticket":"test"},{"type":"ticker","codes": \(codes)}]
                    """)
            // 데이터 수신
            case .binary(let data):
                
                guard let json = try? JSONDecoder().decode(CoinTicker.self, from: data) else { return }
                
                
                
            default: return
            }
        }
    }
}
