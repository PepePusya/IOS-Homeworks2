//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/05/10.
//

import Foundation

class CurrentUserService: UserService {
    private var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func getUser(login: String, completion: @escaping (Result<User, LoginError>) -> Void) {
        if login == user.login {
            completion(.success(user))
        } else {
            completion(.failure(.invalidCredentials))
        }
    }
}
