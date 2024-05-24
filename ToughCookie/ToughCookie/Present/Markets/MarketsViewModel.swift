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
    
    let input = Input()
    
    var disposeBag = DisposeBag()
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    struct Input {
        
        let languageTypeRelay = PublishRelay<Void>()
        let sortedTypeRelay = PublishRelay<CoinSortedType>()
    }
    
    struct Output {
        
        let sortedTickerPresentDataDriver: Driver<[TickerPresentData]>
        let languageTypeDriver: Driver<Void>
        let sortedTypeDriver: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        
        let sortedTickerPresentDataDriver = sortedTickerPresentData
            .throttle(.milliseconds(200), scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: [TickerPresentData.dummyData()])
        
        let languageTypeDriver = PublishRelay<Void>()
        
        // Coin Repository의 language 타입 변경
        input.languageTypeRelay.subscribe(with: self) { owner, _ in
            
            let curLanguageType = CoinRepository.shared.languageType
            let newLanguageType: CoinLanguageType = curLanguageType == .korean ? .english : .korean
            
            owner.repository.languageType = newLanguageType
            
            languageTypeDriver.accept(())
        }.disposed(by: disposeBag)
        
        let sortedTypeDriver = PublishRelay<Void>()
        
        // Coin Repository의 sorted 타입 변경
        input.sortedTypeRelay.subscribe(with: self) { owner, sortedType in
            
            switch sortedType {
                
            case .tradePrice:
            
                if owner.repository.sortedType == .tradePriceASC {
                    owner.repository.sortedType = .tradePriceDESC
                    
                } else if owner.repository.sortedType == .tradePriceDESC {
                    owner.repository.sortedType = .tradePrice
                } else {
                    owner.repository.sortedType = .tradePriceASC
                }
                
            case .change:
                
                if owner.repository.sortedType == .changeASC {
                    owner.repository.sortedType = .changeDESC
                } else if owner.repository.sortedType == .changeDESC {
                    owner.repository.sortedType = .change
                } else {
                    owner.repository.sortedType = .changeASC
                }
                
            case .accTradePrice:
                
                if owner.repository.sortedType == .accTradePriceASC {
                    owner.repository.sortedType = .accTradePriceDESC
                } else if owner.repository.sortedType == .accTradePriceDESC {
                    owner.repository.sortedType = .accTradePrice
                } else {
                    owner.repository.sortedType = .accTradePriceASC
                }
                
            default: break
            }
            
            sortedTypeDriver.accept(())
            
        }.disposed(by: disposeBag)
        
        
        return Output(sortedTickerPresentDataDriver: sortedTickerPresentDataDriver,
                      languageTypeDriver: languageTypeDriver.asDriver(onErrorJustReturn: ()),
                      sortedTypeDriver: sortedTypeDriver.asDriver(onErrorJustReturn: ()))
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
