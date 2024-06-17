//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/06/02.
//


import Foundation
import UIKit

class FeedViewModel {
    private let feedModel = FeedModel(secretWord: "password")
    var resultText: ((String) -> Void)?
    var resultColor: ((UIColor) -> Void)?
    
    func checkGuess(_ guess: String?) {
        guard let guess = guess, !guess.isEmpty else { return }
        if feedModel.check(word: guess) {
            resultText?("Correct!")
            resultColor?(.green)
        } else {
            resultText?("Wrong!")
            resultColor?(.red)
        }
    }
}
