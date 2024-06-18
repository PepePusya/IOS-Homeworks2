//
//  LoginInspector.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/05/17.

class LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        return login == "correctLogin" && password == "correctPassword"
    }
}
