//
//  UpbitRouter.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/18/24.
//

import Foundation
import Alamofire

enum UpbitRouter: RouterProtocol {
    
    case fetchMarketAll
}

extension UpbitRouter {
    
    var baseURL: String {
        
        return "https://api.upbit.com/v1"
    }
    
    var method: Alamofire.HTTPMethod {
        
        switch self {
        case .fetchMarketAll:
            return .get
        }
    }
    
    var path: String {
        
        switch self {
        case .fetchMarketAll:
            return "/market/all"
        }
    }
    
    var parameters: Alamofire.Parameters? {
        
        return nil
    }
    
    var header: [String : String] {
        
        switch self {
        default: return [:]
        }
    }
    
    var body: Data? {
        
        let _ = JSONEncoder()
        // encoder.keyEncodingStrategy = .useDefaultKeys
        
        switch self {
            
        default: return nil
        }
    }
}
