//
//  ProfileViewController.swift
//  NavigationLast
//
//  Created by Anna Zaytseva on 2023/12/18.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "profileimage")
        return imageView
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileImageView)
        
        
        view.backgroundColor = .white
        navigationItem.title = "Profile"
        
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        
        
        
       
    }
}
