//
//  ExtensionUIView.swift
//  ios-homeworks-feature-iosui2
//
//  Created by Anna Zaytseva on 2024/05/04.
//

import Foundation
import UIKit

public extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for i in subviews {
            self.addSubview(i)
        }
    }
}
