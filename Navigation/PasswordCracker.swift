//
//  PasswordCracker.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/06/15.
//

import Foundation

class PasswordCracker {
    let allowedCharacters: [Character] = Array("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")

    func bruteForce(passwordToUnlock: String, completion: @escaping (String) -> Void) {
        var password: String = ""
        
        while password != passwordToUnlock {
            password = generateBruteForce(password, fromArray: allowedCharacters)
        }
        
        completion(password)
    }

    private func generateBruteForce(_ string: String, fromArray array: [Character]) -> String {
        var str = string

        if str.count <= 0 {
            str.append(array[0])
        } else {
            str.replace(at: str.count - 1,
                        with: array[(array.firstIndex(of: str.last!)! + 1) % array.count])
            
            if array.firstIndex(of: str.last!) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }

        return str
    }
}

private extension String {
    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}
