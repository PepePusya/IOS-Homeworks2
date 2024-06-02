//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/05/17.


import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        let loginViewController = LoginViewController()
        let loginInspector = LoginInspector()
        loginViewController.loginDelegate = loginInspector
        window?.rootViewController = UINavigationController(rootViewController: loginViewController)
        window?.makeKeyAndVisible()
    }

}
