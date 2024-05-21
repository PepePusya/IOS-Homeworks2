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

        let window = UIWindow(windowScene: windowScene)
        let loginVC = LoginViewController()

        let factory = MyLoginFactory()
        loginVC.loginDelegate = factory.makeLoginInspector()

        window.rootViewController = UINavigationController(rootViewController: loginVC)
        self.window = window
        window.makeKeyAndVisible()
    }
}
