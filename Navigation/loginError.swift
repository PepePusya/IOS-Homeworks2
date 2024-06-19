//
//  loginError.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/06/18.
//


import Foundation

enum LoginError: Error {
    case emptyCredentials
    case invalidCredentials
    case networkError
    case unknownError
}
