//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/05/21.
//

import Foundation
import UIKit

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
         return LoginInspector()
    }
}
