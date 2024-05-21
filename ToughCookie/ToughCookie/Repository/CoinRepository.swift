//
//  CoinRepository.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/21/24.
//

import Foundation

class CoinRepository {
    
    static let shared = CoinRepository()
    
    private init() { }
    
    var marketData: [MarketData] = []
    
    var tickerDict: [String: TickerData] = [:]
    
    func updateTickerDict(_ data: TickerData) {
        
        tickerDict[data.code] = data
    }
    
    func sortedTickerList() -> [TickerData] {
        
        return tickerDict.values.sorted { $0.accTradePrice24H > $1.accTradePrice24H }.compactMap { $0 }
    }
    
    func getMarketDatumByTicker(_ data: TickerData) -> MarketData {
        
        guard let marketDatum = self.marketData.filter({ $0.market == data.code }).first else { return MarketData(market: "", koreanName: "", englishName: "")}
        
        return marketDatum
    }
}
