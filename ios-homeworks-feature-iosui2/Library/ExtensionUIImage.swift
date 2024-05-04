//
//  ExtensionUIImage.swift
//  ios-homeworks-feature-iosui2
//
//  Created by Anna Zaytseva on 2024/05/04.
//

import UIKit

public extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
