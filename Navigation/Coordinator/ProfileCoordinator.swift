//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/06/12.
//

import UIKit

class ProfileCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let profileViewController = ProfileViewController()
        profileViewController.coordinator = self
        navigationController.pushViewController(profileViewController, animated: false)
    }
}
