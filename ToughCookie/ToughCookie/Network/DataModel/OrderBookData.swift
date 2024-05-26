//
//  OrderBookData.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/26/24.
//

import Foundation

struct OrderBookData: Decodable {
    
    let type: String
    let code: String
    let totalAskSize: Double?
    let totalBidSize: Double?
    let orderbookUnits: [OrderBookUnits]?
    
    enum CodingKeys: String, CodingKey {
        case type, code
        case totalAskSize = "total_ask_size"
        case totalBidSize = "total_bid_size"
        case orderbookUnits = "orderbook_units"
    }
}

struct OrderBookUnits: Decodable {
    
    let askPrice: Double
    let bidPrice: Double
    let askSize: Double
    let bidSize: Double
    
    enum CodingKeys: String, CodingKey {
        case askPrice = "ask_price"
        case bidPrice = "bid_price"
        case askSize = "ask_size"
        case bidSize = "bid_size"
    }
}
