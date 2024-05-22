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
    let customSectionRelay = PublishRelay<[TickerSection]>()
    
    var disposeBag = DisposeBag()
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    struct Input { }
    
    struct Output {
        
        let customSectionDrive: Driver<[TickerSection]>
    }
    
    func transform(_ input: Input) -> Output {
        
        let customSectionDrive = customSectionRelay
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: [])
        
        return Output(customSectionDrive: customSectionDrive)
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
                self.repository.updateTickerDict(tickerData)
                // 정렬된 Ticker Data 생성
                let sortedTickerData = self.repository.sortedTickerList()
                // Ticker Section 생성 및 전달
                let customSection = [TickerSection(items: sortedTickerData)]
                
                self.customSectionRelay.accept(customSection)
                
            default: return
            }
        }
    }
}
