//
//  Theme.swift
//  memorizeGame
//
//  Created by Youssef Ismail on 2022-05-11.
//

import Foundation

struct Theme<CardContent> {
    private(set) var name: String
    private(set) var emojis: [CardContent]
    private(set) var numberOfPairs: Int
    private(set) var color: String
}
