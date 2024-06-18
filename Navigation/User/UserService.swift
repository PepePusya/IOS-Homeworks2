//
//  UserService.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/05/10.
//
import Foundation



protocol UserService {
    func getUser(login: String, completion: @escaping (Result<User, LoginError>) -> Void)
}
