//
//  LoginInspector.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/05/17.


import Foundation

struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        return Checker.shared.check(login: login, password: password)
    }
}
