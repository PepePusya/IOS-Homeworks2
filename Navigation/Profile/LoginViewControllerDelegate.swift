//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/05/17.


import Foundation
import UIKit

protocol LoginViewControllerDelegate  {
    func check(login: String, password: String) -> Bool
}
