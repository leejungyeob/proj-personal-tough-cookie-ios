//
//  TabBarItemType.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/18/24.
//

import Foundation

enum TabBarItemType: String, CaseIterable {
    
    case markets
    
    init?(index: Int) {
        
        switch index {
        case 0: self = .markets
        default: return nil
        }
    }
    
    func toInt() -> Int {
        
        switch self {
        case .markets: return 0
        }
    }
    
    func toName() -> String {
        
        switch self {
        case .markets: return "거래소"
        }
    }
    
    func toIconName() -> String {
        
        switch self {
        case .markets: return "house.fill"
        }
    }
}
