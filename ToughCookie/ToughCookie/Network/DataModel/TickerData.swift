//
//  TickerData.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/21/24.
//

import Foundation

struct TickerData: Decodable, Hashable {
    let type: String // ticker : 현재가
    let code: String
    let tradePrice: Double
    let change: String // RISE : 상승, EVEN : 보합, FALL : 하락
    let changePrice: Double
    let changeRate: Double
    let accTradePrice: Double
    let accTradePrice24H: Double
    
    enum CodingKeys: String, CodingKey {
        case type, code, change
        case tradePrice = "trade_price"
        case accTradePrice = "acc_trade_price"
        case changePrice = "change_price"
        case changeRate = "change_rate"
        case accTradePrice24H = "acc_trade_price_24h"
    }
    
    func transformToTickerPresentData() -> TickerPresentData {
        
        return TickerPresentData(type: type, code: code, tradePrice: tradePrice, change: change, changePrice: changePrice, changeRate: changeRate, accTradePrice: accTradePrice, accTradePrice24H: accTradePrice24H)
    }
}
