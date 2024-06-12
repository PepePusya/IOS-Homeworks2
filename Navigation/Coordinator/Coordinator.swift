//
//  Coordinator.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/06/12.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
