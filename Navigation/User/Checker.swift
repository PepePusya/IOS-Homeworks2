//
//  Checker.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/05/17.

import UIKit
import Foundation

class Checker {
    static let shared = Checker()

    private let validLogin = "correctLogin"
    private let validPassword = "correctPassword"

    private init() {}

    func check(login: String, password: String) -> Bool {
        return login == validLogin && password == validPassword
    }
}
