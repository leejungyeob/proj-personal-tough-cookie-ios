//
//  UIViewController++.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/26/24.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UIViewController {
    
    var viewWillAppearObservable: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    var viewDidAppearObservable: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewDidAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    var viewWillDisappearObservable: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewWillDisappear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
}
