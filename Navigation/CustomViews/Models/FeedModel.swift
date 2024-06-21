//
//  FeedModel.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/05/31.
//
import Foundation

class FeedModel {
    private let secretWord: String

    init(secretWord: String) {
        self.secretWord = secretWord
    }

    func check(word: String) -> Bool {
        return word == secretWord
    }
}
