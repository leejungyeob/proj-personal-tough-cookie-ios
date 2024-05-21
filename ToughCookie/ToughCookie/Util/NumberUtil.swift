//
//  NumberUtil.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/21/24.
//

import UIKit

class NumberUtil {
    
    static func changeDecimalToPercentage(_ number: Double) -> Double {
        
        let percentage = number * 100
        let str = String(format: "%.2f", percentage)
        
        return Double(str) ?? 0
    }
    
    static func changeDoubleToDecimalStr(_ number: Double) -> String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let decimal = numberFormatter.string(for: number) ?? ""
        
        return decimal
    }
    
    static func changeDoubleToOneMillionStr(_ number: Double) -> String {
        
        var num: Double = 0
        
        if number > 1000000 { num = Double(Int(number) / 1000000) }
        
        let oneMillionStr = changeDoubleToDecimalStr(num) + "백만"
        
        return oneMillionStr
    }
}

enum CoinSign: String {
    
    case rise = "RISE"
    case even = "EVEN"
    case fall = "FALL"
    
    var sign: String {
        
        switch self {
        case .rise, .even:
            return ""
        case .fall:
            return "-"
        }
    }
    
    var color: UIColor {
        
        switch self {
        case .rise:
            return .systemRed
        case .even:
            return .white
        case .fall:
            return .systemBlue
        }
    }
}
