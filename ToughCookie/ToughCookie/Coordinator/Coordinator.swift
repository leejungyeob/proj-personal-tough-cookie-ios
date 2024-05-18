//
//  Coordinator.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/18/24.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var coordinatorType: CoordinatorType { get }
    
    var navigationController: UINavigationController { get set }
    
    var childCoordinators: [Coordinator] { get set }
    
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    
    func start()
    
    func finish()
    
    init(_ navigationController: UINavigationController)
}

extension Coordinator {
    
    func finish() {
        
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

protocol CoordinatorFinishDelegate: AnyObject {
    
    func coordinatorDidFinish(childCoordinator: Coordinator)
}

enum CoordinatorType {
    
    case app
    
    case tab
    case markets
    
    var title: String {
        
        switch self {
            
        case .markets:
            return "거래소"
        default: return ""
        }
    }
}
