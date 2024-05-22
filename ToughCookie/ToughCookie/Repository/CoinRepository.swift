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
    
    var tickerDict: [String: TickerPresentData] = [:]
    
    func updateTickerDict(_ data: TickerPresentData) {
        
        if data.accTradePrice24H < 1000000 { return }
        
        guard let oldData = tickerDict[data.code] else {
            tickerDict[data.code] = data
            return
        }
        
        var newData = data
        
        if oldData.tradePrice > newData.tradePrice {
            newData.updateTradePriceSign = .fall
        } else if oldData.tradePrice < newData.tradePrice {
            newData.updateTradePriceSign = .rise
        }
        
        tickerDict[data.code] = newData
    }
    
    func sortedTickerList() -> [TickerPresentData] {
        
        return tickerDict.values.sorted { $0.accTradePrice24H > $1.accTradePrice24H }.compactMap { $0 }
    }
    
    func getMarketDatumByTickerPresentData(_ data: TickerPresentData) -> MarketData {
        
        guard let marketDatum = self.marketData.filter({ $0.market == data.code }).first else { return MarketData(market: "", koreanName: "", englishName: "")}
        
        return marketDatum
    }
}
