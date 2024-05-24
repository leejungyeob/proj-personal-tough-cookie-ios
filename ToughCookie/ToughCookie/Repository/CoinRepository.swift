//
//  CoinRepository.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/21/24.
//

import Foundation
import UIKit.UIColor

class CoinRepository {
    
    static let shared = CoinRepository()
    
    private init() { }
    
    var marketData: [MarketData] = []
    
    var tickerDict: [String: TickerPresentData] = [:]
    
    var languageType: CoinLanguageType = .korean
    var sortedType: CoinSortedType = .nothing
    
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
        
        switch sortedType {
        case .nothing:
            return tickerDict.values.sorted { $0.accTradePrice24H > $1.accTradePrice24H }.compactMap { $0 }
        case .tradePriceASC:
            return tickerDict.values.sorted { $0.tradePrice < $1.tradePrice }.compactMap { $0 }
        case .tradePriceDESC:
            return tickerDict.values.sorted { $0.tradePrice > $1.tradePrice }.compactMap { $0 }
        case .changeASC:
            return tickerDict.values.sorted { $0.changeRate < $1.changeRate }.compactMap { $0 }
        case .changeDESC:
            return tickerDict.values.sorted { $0.changeRate > $1.changeRate }.compactMap { $0 }
        case .accTradePriceASC:
            return tickerDict.values.sorted { $0.accTradePrice24H < $1.accTradePrice24H }.compactMap { $0 }
        case .accTradePriceDESC:
            return tickerDict.values.sorted { $0.accTradePrice24H > $1.accTradePrice24H }.compactMap { $0 }
        default:
            return tickerDict.values.sorted { $0.accTradePrice24H > $1.accTradePrice24H }.compactMap { $0 }
        }
        
        
    }
    
    func getMarketDatumByTickerPresentData(_ data: TickerPresentData) -> MarketData {
        
        guard let marketDatum = self.marketData.filter({ $0.market == data.code }).first else { return MarketData(market: "", koreanName: "", englishName: "")}
        
        return marketDatum
    }
}

enum CoinLanguageType {
    
    case korean
    case english
}

enum CoinSortedType {
    
    case nothing
    
    case tradePrice
    case tradePriceASC
    case tradePriceDESC
    
    case change
    case changeASC
    case changeDESC
    
    case accTradePrice
    case accTradePriceASC
    case accTradePriceDESC
    
    var title: String {
        
        switch self {
        case .tradePrice, .tradePriceASC, .tradePriceDESC:
            return "현재가"
        case .change, .changeASC, .changeDESC:
            return "전일대비"
        case .accTradePrice, .accTradePriceASC , .accTradePriceDESC:
            return "누적대금"
        case .nothing:
            return ""
        }
    }
    
    var imageName: String {
        
        switch self {
        case .tradePrice, .tradePriceASC, .change, .changeASC, .accTradePrice, .accTradePriceASC:
            return "arrow.up"
        case .accTradePriceDESC, .changeDESC, .tradePriceDESC:
            return "arrow.down"
        case .nothing:
            return ""
        }
    }
    
    var color: UIColor {
        
        switch self {
        case .nothing, .accTradePrice ,.change ,.tradePrice:
            return UIColor.white
        default:
            return UIColor.systemYellow
        }
    }
}
