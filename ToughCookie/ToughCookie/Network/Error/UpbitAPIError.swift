//
//  UpbitAPIError.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/18/24.
//

import Foundation

enum UpbitAPIError: Int, Error {
    
    /// status - 200
    case invalidDataModel = 200
    
    /// status - 400
    case fail = 400
    
    /// 999
    case invalidURL
}
