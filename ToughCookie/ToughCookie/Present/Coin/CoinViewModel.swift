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
    
    private var cancellable = Set<AnyCancellable>()
    private var coordinator: Coordinator
    
    var tickerPresentData: TickerPresentData    // MarketsVC에서 가져온 Data
    @Published var askOrderBook: [OrderBookItem] = []
    @Published var bidOrderBook: [OrderBookItem] = []
    @Published var updateTickerData: TickerPresentData = .dummyData()   // WebSocket에서 업데이트한 Data
    
    private var repository: CoinRepository = CoinRepository.shared
    private let coinWebSocket = WebSocketManager()
    private let marketWebSocket = WebSocketManager()
    
    private var receivedAskOrderBook = PassthroughSubject<[OrderBookItem], Never>()
    private var receivedBidOrderBook = PassthroughSubject<[OrderBookItem], Never>()
    private var receivedTickerPresentData = PassthroughSubject<TickerPresentData, Never>()
    
    var disposeBag = DisposeBag()
    
    init(coordinator: Coordinator, tickerPresentData: TickerPresentData) {
        self.coordinator = coordinator
        self.tickerPresentData = tickerPresentData
        
        // ask Order Book 업데이트
        receivedAskOrderBook
            .receive(on: DispatchQueue.main)
            .sink { orderBookItems in
                self.askOrderBook = orderBookItems
            }.store(in: &cancellable)
        
        // bid Order Book 업데이트
        receivedBidOrderBook
            .receive(on: DispatchQueue.main)
            .sink { bidOrderItems in
                self.bidOrderBook = bidOrderItems
            }.store(in: &cancellable)
        
        // ticker present data 업데이트
        receivedTickerPresentData
            .receive(on: DispatchQueue.main)
            .sink { tickerPresentData in
                self.updateTickerData = tickerPresentData
            }.store(in: &cancellable)
    }
    
    func connect() {
        
        connectCoin()
        connectMarket()
    }
    
    func connectCoin() {
        
        let codes = [tickerPresentData.code]
        let socket = coinWebSocket.connect() // 웹소켓 연결
        
        socket.onEvent = { [weak self] event in
            
            guard let self else { return }
            
            switch event {
                
                // 데이터 요청
            case .connected(_):
                
                coinWebSocket.send("""
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
    
    func connectMarket() {
     
        let codes = [tickerPresentData.code]
        let socket = marketWebSocket.connect() // 웹소켓 연결
        
        socket.onEvent = { [weak self] event in
            
            guard let self else { return }
            
            switch event {
                
                // 데이터 요청
            case .connected(_):
                
                marketWebSocket.send("""
                      [{"ticket":"test"},{"type":"ticker","codes": \(codes)}]
                    """)
                
                // 데이터 수신
            case .binary(let data):
                
                guard let tickerData: TickerData = try? JSONDecoder().decode(TickerData.self, from: data) else { return }
                
                let presentData = tickerData.transformToTickerPresentData()
                
                // CoinRepository.shared.updateTickerDict(presentData)
                
                self.receivedTickerPresentData.send(presentData)
                
            default: return
            }
        }
    }
    
    func disconnect() {
        coinWebSocket.disconnect()
        marketWebSocket.disconnect()
    }
}
