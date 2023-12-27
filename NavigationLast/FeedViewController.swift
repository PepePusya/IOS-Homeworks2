//
//  FeedViewController.swift
//  NavigationLast
//
//  Created by Anna Zaytseva on 2023/12/18.
//

import Foundation
import UIKit

class FeedViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationItem.title = "Line"
        
        let button = UIButton(frame: CGRect(x: 100.0, y: 100.0, width: 200.0, height: 50.0))
        button.setTitle("Open Post", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        view.addSubview(button)
    }
    @objc func showPost() {
        let post = Post(title: "Post")
        let postVC = PostViewController(post: post)
        navigationController?.pushViewController(postVC, animated: true)
    }
}
