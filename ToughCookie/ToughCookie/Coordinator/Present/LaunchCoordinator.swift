//
//  LaunchCoordinator.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/18/24.
//

import UIKit

protocol LaunchCoordinatorProtocol: Coordinator {
    
    var marketAllData: [MarketData] { get set }
    
    func showLaunchView()
}

final class LaunchCoordinator: LaunchCoordinatorProtocol {
    
    var coordinatorType: CoordinatorType { .launch }
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var marketAllData: [MarketData] = [] {
        didSet { finish() }
    }
    
    required init(_ navigationController: UINavigationController) {
        
        self.navigationController = navigationController
    }
    
    deinit {
        print("deinit - launchCoordinator")
    }
}

extension LaunchCoordinator {
    
    func start() {
        
        showLaunchView()
    }
    
    /// Launch VC 연결
    func showLaunchView() {
     
        let launchViewModel = LaunchViewModel()
        let launchViewController = LaunchViewController(viewModel: launchViewModel)
        
        launchViewModel.coordinator = self
        
        navigationController.setNavigationBarHidden(true, animated: false)
        
        navigationController.setViewControllers([launchViewController], animated: true)
    }
}
