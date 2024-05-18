//
//  ViewModelProtocol.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/18/24.
//

import Foundation
import RxSwift

protocol ViewModelProtocol: AnyObject {
    
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(_ input: Input) -> Output
}
