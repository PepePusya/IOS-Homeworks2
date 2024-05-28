//
//  UserService.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/05/10.
//

import Foundation
import UIKit

protocol UserService {
    func getUser(login: String) -> User?
}
