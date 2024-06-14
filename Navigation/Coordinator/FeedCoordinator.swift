//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/06/12.

import UIKit

final class FeedCoordinator: Coordinator {
    var navigationController: UINavigationController

    enum Presentation {
        case post
        case info
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let feedViewController = FeedViewController()
        feedViewController.coordinator = self
        navigationController.pushViewController(feedViewController, animated: false)
    }

    func present(_ presentation: Presentation) {
        switch presentation {
        case .post:
            let post = postExamples[0]
            let postVC = PostViewController()
            postVC.post = post
            navigationController.pushViewController(postVC, animated: true)
        case .info:
            let infoVC = InfoViewController()
            navigationController.present(infoVC, animated: true, completion: nil)
        }
    }
}
