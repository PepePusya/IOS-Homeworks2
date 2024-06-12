//
//  CoordinatorController.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/06/12.
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showLogin()
    }

    func showLogin() {
        let loginViewController = LoginViewController()
        loginViewController.coordinator = self
        navigationController.pushViewController(loginViewController, animated: false)
    }

    func showMainTabBar() {
        let tabBarController = UITabBarController()
        
        let feedNavigationController = UINavigationController()
        let profileNavigationController = UINavigationController()
        
        let feedCoordinator = FeedCoordinator(navigationController: feedNavigationController)
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        
        feedCoordinator.start()
        profileCoordinator.start()
        
        tabBarController.viewControllers = [
            profileCoordinator.navigationController,
            feedCoordinator.navigationController
        ]
        
        navigationController.setViewControllers([tabBarController], animated: true)
    }
}
