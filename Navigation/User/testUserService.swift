//
//  testUserService.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/05/10.
//

import Foundation
import UIKit

class TestUserService: UserService {
    func getUser(login: String, completion: @escaping (Result<User, LoginError>) -> Void) {

    }
    
    private var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func getUser(login: String) -> User? {
        print("Attempting login for: \(login)")
        if login == user.login {
            print("Login successful for: \(login)")
            return user
        } else {
            print("Login failed for: \(login), expected: \(user.login)")
            return nil
        }
    }
}
