//
//  MarketsCoordinator.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/18/24.
//

import UIKit

protocol MarketsCoordinatorProtocol: Coordinator {
    
    var marketsTabViewController: MarketsViewController { get set }
}

class MarketsCoordinator: MarketsCoordinatorProtocol {
    
    var marketsTabViewController: MarketsViewController
    
    var coordinatorType: CoordinatorType { .markets }
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    required init(_ navigationController: UINavigationController) {
        
        self.navigationController = navigationController
        self.marketsTabViewController = MarketsViewController()
    }
}

extension MarketsCoordinator {
    
    func start() {
        
        self.navigationController.pushViewController(self.marketsTabViewController, animated: false)
        
        self.navigationController.navigationBar.topItem?.title = coordinatorType.title
    }
}

extension MarketsCoordinator: CoordinatorFinishDelegate {
    
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        
        self.childCoordinators = self.childCoordinators.filter { $0.coordinatorType != childCoordinator.coordinatorType }
        childCoordinator.navigationController.popToRootViewController(animated: true)
    }
}
