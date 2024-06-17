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
    
    func getUser(login: String) -> User? {
        return login == user.login ? user : nil
        }
    }

