//
//  OpenViewController.swift
//  NavigationLast
//
//  Created by Anna Zaytseva on 2023/12/18.
//

import Foundation
import UIKit

class InfoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        button.setTitle("Show Alert", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func showAlert() {
        let alert = UIAlertController(title: "Info", message: "This message from InfoViewController", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            print ("OK button pushed")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            print("Cancel button pushed")
        }))
        present(alert, animated: true, completion: nil)
    }
}
