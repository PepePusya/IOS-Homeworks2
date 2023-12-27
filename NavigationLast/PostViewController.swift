//
//  PostViewController.swift
//  NavigationLast
//
//  Created by Anna Zaytseva on 2023/12/18.
//

import Foundation
import UIKit

struct Post {
    let title: String
}
class PostViewController: UIViewController {
    private let post: Post
    
    init(post: Post) {
        self.post = post
        super .init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        title = post.title
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(showInfo))
    }
    
    @objc func showInfo() {
        let infoVC = InfoViewController()
        present(infoVC, animated: true, completion: nil)
    }
}
