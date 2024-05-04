//
//  PostViewController.swift
//  ios-homeworks-feature-iosui2
//
//  Created by Anna Zaytseva on 2024/04/24.
//

import Foundation
import StorageService
import UIKit

final class PostViewController: UIViewController {
    
    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = post?.author ?? "-"
        view.backgroundColor = .systemYellow
        
        // add a button in the navigtion bar
        let barButton = UIBarButtonItem(title: "Info", style: .done, target: self, action: #selector(tapInfoButton))
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func tapInfoButton() {
        let infoVC = InfoViewController()
        present(infoVC, animated: true, completion: nil)
    }
}
