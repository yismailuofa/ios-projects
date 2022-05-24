//
//  Card.swift
//  SetGame
//
//  Created by Youssef Ismail on 2022-05-16.
//

import Foundation
import SwiftUI

struct Card:Equatable, Hashable, Identifiable {
    let id = UUID()
    let count: Count
    let symbol: Symbols
    var state: State
    let color: Color
    let shading: Shading
    
    enum Symbols: String, CaseIterable {
        case oval = "oval"
        case diamond = "diamond"
        case rectangle = "rectangle"
    }
    
    enum State {
        case unselected
        case selected
        case correctlySelected
        case incorrectlySelected
        case matched
    }
    
    enum Color: String, CaseIterable {
        case red = "red"
        case purple = "purple"
        case green = "green"
    }
    
    enum Shading: String, CaseIterable {
        case hollow = "hollow"
        case filled = "filled"
        case striped = "striped"
    }
    
    enum Count: Int, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
    }
}
