//
//  User.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/05/10.
//

import Foundation
import UIKit

class User {
    var login: String
    var fullName: String
    var avatar: UIImage
    var status: String

    init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}
