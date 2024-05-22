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
    let openingPrice: Double
    let highPrice: Double
    let lowPrice: Double
    let tradePrice: Double
    let prevClosingPrice: Double
    let change: String // RISE : 상승, EVEN : 보합, FALL : 하락
    let changePrice: Double
    let signedChangePrice: Double
    let changeRate: Double
    let signedChangeRate: Double
    let tradeVolume: Double
    let accTradeVolume: Double
    let accTradeVolume24H: Double
    let accTradePrice: Double
    let accTradePrice24H: Double
    let tradeDate: String // yyyyMMdd
    let tradeTime: String // HHmmss
    let tradeTimestamp: Int
    let askBid: String
    let accAskVolume: Double
    let accBidVolume: Double
    let highest52WeekPrice: Int
    let highest52WeekDate: String
    let lowest52WeekPrice: Int
    let lowest52WeekDate: String
    let tradeStatus: String?
    let marketState: String
    let marketStateForIOS: String?
    let isTradingSuspended: Bool
    let delistingDate: String?
    let marketWarning: String
    let timestamp: Int
    let streamType: String
    var updateTradePriceSign: CoinSign = .even
    
    static func dummyData() -> TickerPresentData {
        
        return TickerPresentData(type: "-", code: "-", openingPrice: 0, highPrice: 0, lowPrice: 0, tradePrice: 0, prevClosingPrice: 0, change: "-", changePrice: 0, signedChangePrice: 0, changeRate: 0, signedChangeRate: 0, tradeVolume: 0, accTradeVolume: 0, accTradeVolume24H: 0, accTradePrice: 0, accTradePrice24H: 0, tradeDate: "-", tradeTime: "-", tradeTimestamp: 0, askBid: "-", accAskVolume: 0, accBidVolume: 0, highest52WeekPrice: 0, highest52WeekDate: "-", lowest52WeekPrice: 0, lowest52WeekDate: "-", tradeStatus: "-", marketState: "-", marketStateForIOS: "-", isTradingSuspended: false, delistingDate: "-", marketWarning: "-", timestamp: 0, streamType: "-")
    }
}
