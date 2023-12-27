//
//  ProfileViewController.swift
//  ios-homeworks-feature-iosui2
//
//  Created by Anna Zaytseva on 2023/11/08.
//

import Foundation
import UIKit
 

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        let profileHeaderView = ProfileHeaderView()
        
        view.addSubview(profileHeaderView)
        profileHeaderView.frame = view.bounds
    }
    
    @objc func buttonPressed() {
        
    }
    
}
