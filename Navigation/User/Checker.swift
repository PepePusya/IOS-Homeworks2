//
//  Checker.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/05/17.

import UIKit
import Foundation

final class Checker {
    static let shared = Checker()
    
    private let login = "correctLogin"
    private let password = "correctPassword"
    
    private init() {}
    
    func check(login: String, password: String) -> Bool {
        return self.login == login && self.password == password
    }
}
