//
//  LaunchCoordinator.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/18/24.
//

import UIKit

protocol LaunchCoordinatorProtocol: Coordinator {
    
    func showLaunchView()
}

class LaunchCoordinator: LaunchCoordinatorProtocol {
    
    var coordinatorType: CoordinatorType { .launch }
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    required init(_ navigationController: UINavigationController) {
        
        self.navigationController = navigationController
    }
}

extension LaunchCoordinator {
    
    func start() {
        
        showLaunchView()
    }
    
    func showLaunchView() {
     
        let launchViewModel = LaunchViewModel()
        let launchViewController = LaunchViewController(viewModel: launchViewModel)
        
        navigationController.setNavigationBarHidden(true, animated: false)
        
        navigationController.setViewControllers([launchViewController], animated: true)
    }
    
}
