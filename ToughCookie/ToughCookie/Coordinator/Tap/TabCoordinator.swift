//
//  TabCoordinator.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/18/24.
//

import UIKit

protocol TabCoordinatorProtocol: Coordinator {
    
    var tabBarController: UITabBarController { get set }
}

class TabCoordinator: TabCoordinatorProtocol {
    
    var tabBarController: UITabBarController
    
    var coordinatorType: CoordinatorType { .tab }
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    required init(_ navigationController: UINavigationController) {
        
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }
    
    
}

extension TabCoordinator {
    
    func start() {
        
        let pages: [TabBarItemType] = TabBarItemType.allCases
        
        let tabBarItems: [UITabBarItem] = pages.map { self.createTabBarItem(of: $0) }
        
        let controllers: [UINavigationController] = tabBarItems.map {
            self.createTabNavigationController(tabBarItem: $0)
        }
        
        let _ = controllers.map { self.startTabCoordinator(tabNavigationController: $0) }
        
        self.configureTabBarController(tabNavigationControllers: controllers)
        
        self.addTabBarController()
    }
    
    func createTabBarItem(of page: TabBarItemType) -> UITabBarItem {
        
        let iconImageConfiguration = UIImage.SymbolConfiguration(scale: .medium)
        let iconImage = UIImage(systemName: page.toIconName())?.withConfiguration(iconImageConfiguration)
        
        let tabBarItem = UITabBarItem(title: page.toName(),
                                      image: iconImage,
                                      tag: page.toInt())
        
        tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 13, weight: .bold)], for: .normal)
        
        return tabBarItem
    }
    
    func createTabNavigationController(tabBarItem: UITabBarItem) -> UINavigationController {
        
        let tabNavigationController = UINavigationController()
        
        tabNavigationController.setNavigationBarHidden(false, animated: false)
        
        tabNavigationController.navigationBar.topItem?.title = TabBarItemType(index: tabBarItem.tag)?.toName()
        
        tabNavigationController.tabBarItem = tabBarItem
        
        return tabNavigationController
    }
    
    func startTabCoordinator(tabNavigationController: UINavigationController) {
        
        let tabBarItemTag: Int = tabNavigationController.tabBarItem.tag
        guard let tabBarItemType: TabBarItemType = TabBarItemType(index: tabBarItemTag) else { return }
        
        switch tabBarItemType {
        case .markets:
            
            let marketsCoordinator = MarketsCoordinator(tabNavigationController)
            marketsCoordinator.finishDelegate = self
            self.childCoordinators.append(marketsCoordinator)
            marketsCoordinator.start()
        }
    }
    
    func configureTabBarController(tabNavigationControllers: [UINavigationController]) {
        
        self.tabBarController.setViewControllers(tabNavigationControllers, animated: false)
        
        self.tabBarController.selectedIndex = TabBarItemType.markets.toInt()
        
        self.tabBarController.tabBar.backgroundColor = .systemBlue.withAlphaComponent(0.6)
        self.tabBarController.tabBar.tintColor = UIColor.white
    }
    
    func addTabBarController() {
        
        self.navigationController.pushViewController(self.tabBarController, animated: true)
    }
}

extension TabCoordinator: CoordinatorFinishDelegate {
    
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        
        self.childCoordinators.removeAll()
        self.navigationController.viewControllers.removeAll()
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}
