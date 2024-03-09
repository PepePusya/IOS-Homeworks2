//
//  Post.swift
//  ios-homeworks-feature-iosui2
//
//  Created by Anna Zaytseva on 2024/02/17.
//
import UIKit
import Foundation
struct Post {
    let author: String
    let description: String
    let imageName: String
    let likes: Int
    let views: Int
    static func getDummyData() -> [Post] {
        return [
            Post(author: "Pepe Cat", description: "She is a Liar", imageName: "liarCat", likes: 120, views: 300),
            Post(author: "Crazy Dog", description: "Miting with Pepe Cat", imageName: "postImage1", likes: 100, views: 230),
            Post(author: "Crazy Dog", description: "Are you ok, my friend? Are you became a vegetarian?", imageName: "veganCat", likes: 29, views: 450),
            Post(author: "Pusya Rabbit", description: "Haha, soon i will take over the world!", imageName: "Pusya", likes: 400, views: 402)
        ]
    }
}
