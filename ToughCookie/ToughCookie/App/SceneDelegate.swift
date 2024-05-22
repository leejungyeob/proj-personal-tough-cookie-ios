//
//  SceneDelegate.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/13/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    static var detectedEnterForeground: (() -> ()) = { }
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let navVC = UINavigationController()
        
        window.rootViewController = navVC
        window.makeKeyAndVisible()
        window.backgroundColor = .black
        
        let appCoordinator = AppCoordinator(navVC)
        appCoordinator.start()
        
        self.window = window
        setAppearance()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        
        SceneDelegate.detectedEnterForeground()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        WebSocketManager.shared.disconnect()
    }
    
    
}

extension SceneDelegate {
    
    func setAppearance() {
        
        // MARK: Navigation bar appearance
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .subBlue
        navigationBarAppearance.shadowColor = .clear
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // 일반 네이게이션 바 appearance settings
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        // 랜드스케이프 되었을 때 네이게이션 바 appearance settings
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        // 스크롤 엣지가 닿았을 때 네이게이션 바 appearance settings
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        
        // MARK: Tab Bar Item Appearance
        let defaultFont = UIFont.systemFont(ofSize: 13, weight: .bold)
        let textAttributes = [NSAttributedString.Key.font: defaultFont]
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.titleTextAttributes = textAttributes
        tabBarItemAppearance.selected.titleTextAttributes = textAttributes
        
        // MARK: Tab bar appearance
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .systemBlue
        tabBarAppearance.shadowColor = .clear
        tabBarAppearance.inlineLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = tabBarItemAppearance
        
        // 스크롤 엣지가 닿았을 때 탭바 appearance settings
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        // 일반 탭바 appearance settings
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        
    }
}
