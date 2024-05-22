//
//  TickerPresentData.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/22/24.
//

import Foundation

import Foundation

struct TickerPresentData: Hashable {
    let type: String // ticker : 현재가
    let code: String
    let tradePrice: Double
    let change: String // RISE : 상승, EVEN : 보합, FALL : 하락
    let changePrice: Double
    let changeRate: Double
    let accTradePrice: Double
    let accTradePrice24H: Double
    var updateTradePriceSign: CoinSign = .even
    
    static func dummyData() -> TickerPresentData {
        
        return TickerPresentData(type: "-", code: "-", tradePrice: 0, change: "-", changePrice: 0, changeRate: 0, accTradePrice: 0, accTradePrice24H: 0)
    }
}
