//
//  CoinViewModel.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/26/24.
//

import Foundation
import RxSwift
import RxCocoa
import Combine

final class CoinViewModel: ObservableObject {
    
    var cancellable = Set<AnyCancellable>()
    
    var coordinator: Coordinator
    var tickerPresentData: TickerPresentData
    
    var repository: CoinRepository = CoinRepository.shared
    
    @Published
    var askOrderBook: [OrderBookItem] = []
    
    @Published
    var bidOrderBook: [OrderBookItem] = []
    
    var receivedAskOrderBook = PassthroughSubject<[OrderBookItem], Never>()
    var receivedBidOrderBook = PassthroughSubject<[OrderBookItem], Never>()
    
    var disposeBag = DisposeBag()
    
    init(coordinator: Coordinator, tickerPresentData: TickerPresentData) {
        self.coordinator = coordinator
        self.tickerPresentData = tickerPresentData
        
        receivedAskOrderBook
            .receive(on: DispatchQueue.main)
            .sink { orderBookItems in
                self.askOrderBook = orderBookItems
            }.store(in: &cancellable)
        
        receivedBidOrderBook
            .receive(on: DispatchQueue.main)
            .sink { bidOrderItems in
                self.bidOrderBook = bidOrderItems
            }.store(in: &cancellable)
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
                
                let askOrderBook: [OrderBookItem] = orderBookData.orderbookUnits.map {
                    .init(price: $0.askPrice, size: $0.askSize)
                }
                .sorted { $0.price > $1.price }
                
                let bidOrderBook: [OrderBookItem] = orderBookData.orderbookUnits.map {
                    .init(price: $0.bidPrice, size: $0.bidSize)
                }
                .sorted { $0.price > $1.price }
                
                self.receivedAskOrderBook.send(askOrderBook)
                self.receivedBidOrderBook.send(bidOrderBook)
                
            default: return
            }
        }
    }
    
    func disconnect() {
        WebSocketManager.shared.disconnect()
    }
}
