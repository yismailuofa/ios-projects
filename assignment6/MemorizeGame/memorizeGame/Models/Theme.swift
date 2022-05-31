//
//  Theme.swift
//  memorizeGame
//
//  Created by Youssef Ismail on 2022-05-11.
//

import Foundation

struct Theme: Codable, Hashable, Identifiable {
    var name: String
    var emojis: [String]
    var numberOfPairs: Int
    var color: RGBAColor
    var id: Int
}
