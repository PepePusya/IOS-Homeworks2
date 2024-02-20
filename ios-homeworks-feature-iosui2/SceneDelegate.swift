//
//  SceneDelegate.swift
//  ios-homeworks-feature-iosui2
//
//  Created by Anna Zaytseva on 2023/11/08.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let profileVC = ProfileViewController()
        profileVC.title = "Profile"

        let profileNavigationController = UINavigationController(rootViewController: profileVC)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "logo"), selectedImage: nil)

    
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [profileNavigationController]


        window = UIWindow(windowScene: windowScene)
        

        let isAuthenticated = false

        if isAuthenticated {
         
            window?.rootViewController = tabBarController
        } else {
           
            let loginVC = LoginViewController()
            let loginNavigationController = UINavigationController(rootViewController: loginVC)
            
            window?.rootViewController = loginNavigationController
        }
        
        window?.makeKeyAndVisible()
    }
}
