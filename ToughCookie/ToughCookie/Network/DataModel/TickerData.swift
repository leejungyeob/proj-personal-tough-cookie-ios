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
    
    enum CodingKeys: String, CodingKey {
        case type, code, change, timestamp
        case openingPrice = "opening_price"
        case highPrice = "high_price"
        case lowPrice = "low_price"
        case tradePrice = "trade_price"
        case prevClosingPrice = "prev_closing_price"
        case accTradePrice = "acc_trade_price"
        case changePrice = "change_price"
        case signedChangePrice = "signed_change_price"
        case changeRate = "change_rate"
        case signedChangeRate = "signed_change_rate"
        case askBid = "ask_bid"
        case tradeVolume = "trade_volume"
        case accTradeVolume = "acc_trade_volume"
        case tradeDate = "trade_date"
        case tradeTime = "trade_time"
        case tradeTimestamp = "trade_timestamp"
        case accAskVolume = "acc_ask_volume"
        case accBidVolume = "acc_bid_volume"
        case highest52WeekPrice = "highest_52_week_price"
        case highest52WeekDate = "highest_52_week_date"
        case lowest52WeekPrice = "lowest_52_week_price"
        case lowest52WeekDate = "lowest_52_week_date"
        case tradeStatus = "trade_status"
        case marketState = "market_state"
        case marketStateForIOS = "market_state_for_ios"
        case isTradingSuspended = "is_trading_suspended"
        case delistingDate = "delisting_date"
        case marketWarning = "market_warning"
        case accTradePrice24H = "acc_trade_price_24h"
        case accTradeVolume24H = "acc_trade_volume_24h"
        case streamType = "stream_type"
    }
    
    static func dummyData() -> TickerData {
        
        return TickerData(type: "-", code: "-", openingPrice: 0, highPrice: 0, lowPrice: 0, tradePrice: 0, prevClosingPrice: 0, change: "-", changePrice: 0, signedChangePrice: 0, changeRate: 0, signedChangeRate: 0, tradeVolume: 0, accTradeVolume: 0, accTradeVolume24H: 0, accTradePrice: 0, accTradePrice24H: 0, tradeDate: "-", tradeTime: "-", tradeTimestamp: 0, askBid: "-", accAskVolume: 0, accBidVolume: 0, highest52WeekPrice: 0, highest52WeekDate: "-", lowest52WeekPrice: 9999, lowest52WeekDate: "-", tradeStatus: "-", marketState: "-", marketStateForIOS: "-", isTradingSuspended: false, delistingDate: "-", marketWarning: "-", timestamp: 0, streamType: "-")
    }
}
