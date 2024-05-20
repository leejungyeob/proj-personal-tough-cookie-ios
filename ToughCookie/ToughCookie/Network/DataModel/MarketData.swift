//
//  MarketData.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/18/24.
//

import Foundation

struct MarketData: Decodable, Hashable {
    
    let market: String
    let koreanName: String
    let englishName: String
    
    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}
