//
//  PhotoExamples.swift
//  ios-homeworks-feature-iosui2
//
//  Created by Anna Zaytseva on 2024/05/04.
//

import Foundation
import UIKit

final class Photos {
    
    static let shared = Photos()
    
    let examples: [UIImage]
    
    private init() {
        var photos = [UIImage]()
        for i in 1...20 { photos.append((UIImage(named: "\(i)") ?? UIImage())) }
        examples = photos.shuffled()
    }
}

