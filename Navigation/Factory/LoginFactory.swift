//
//  LoginFactory.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/05/21.
//

import Foundation

protocol LoginFactory {
    
    func makeLoginInspector() -> LoginInspector
}
