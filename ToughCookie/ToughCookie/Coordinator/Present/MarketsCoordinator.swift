//
//  MarketsCoordinator.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/18/24.
//

import UIKit

protocol MarketsCoordinatorProtocol: Coordinator {
    
    func showMarketsTabView()
    
    func pushCoinVC(_ data: TickerPresentData)
}

class MarketsCoordinator: MarketsCoordinatorProtocol {
    
    var coordinatorType: CoordinatorType { .markets }
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("deinit - marketsCoordinator")
    }
}

extension MarketsCoordinator {
    
    func start() {
        showMarketsTabView()
    }
    
    func showMarketsTabView() {
        
        let marketsViewModel = MarketsViewModel(coordinator: self)
        let marketsViewController = MarketsViewController(viewModel: marketsViewModel)
        
        marketsViewController.navigationItem.title = coordinatorType.title
        marketsViewController.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        let backButton = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        backButton.tintColor = .mainBlue
        marketsViewController.navigationItem.backBarButtonItem = backButton
        
        self.navigationController.pushViewController(marketsViewController, animated: false)
    }
    
    func pushCoinVC(_ data: TickerPresentData) {
        
        
        let coinViewModel = CoinViewModel(coordinator: self, tickerPresentData: data)
        let rootView = CoinView(viewModel: coinViewModel)
        
        let coinViewController = CoinViewController(rootView: rootView, tickerPresentData: data)
        
        self.navigationController.pushViewController(coinViewController, animated: true)
    }
}

extension MarketsCoordinator: CoordinatorFinishDelegate {
    
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        
        self.childCoordinators = self.childCoordinators.filter { $0.coordinatorType != childCoordinator.coordinatorType }
        childCoordinator.navigationController.popToRootViewController(animated: true)
    }
}
