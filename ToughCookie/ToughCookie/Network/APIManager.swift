//
//  APIManager.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/18/24.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa



struct APIManager {
    
    static func callAPI<T: Decodable>(router: UpbitRouter, dataModel: T.Type) -> Single<Result<T, UpbitAPIError>> {
        
        return Single<Result<T, UpbitAPIError>>.create { single in
            
            do {
                let urlRequest = try router.asURLRequest()
                
                AF.request(urlRequest)
                    .validate(statusCode: 200 ..< 500)
                    .responseDecodable(of: T.self) { response in
                        
                        switch response.result {
                            
                        case .success(let success):
                            
                            single(.success(.success(success)))
                            
                        case .failure(_):
                            
                            guard let response = response.response,
                                  let error = UpbitAPIError(rawValue: response.statusCode)  else { return }
                            
                            single(.success(.failure(error)))
                        }
                    }
                
            } catch {
            
                single(.success(.failure(UpbitAPIError.invalidURL)))
            }
            
            return Disposables.create()
        }
    }
}
