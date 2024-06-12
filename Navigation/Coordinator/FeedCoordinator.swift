//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/06/12.
//

import UIKit

class FeedCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let feedViewController = FeedViewController()
        feedViewController.coordinator = self
        navigationController.pushViewController(feedViewController, animated: false)
    }
}
