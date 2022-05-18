//
//  Card.swift
//  SetGame
//
//  Created by Youssef Ismail on 2022-05-16.
//

import Foundation
import SwiftUI

struct Card {
    enum Symbols {
        case oval
        case diamond
        case rectangle
    }
    
    enum CardState {
        case unselected
        case selected
        case correctlySelected
        case incorrectlySelected
    }
    
    enum CardColor {
        case red
        case purple
        case green
    }
    
    enum CardShading {
        case hollow
        case filled
        case striped
    }
    
    private(set) var count: Int
    private(set) var symbol: Symbols
    private(set) var state: CardState
    private(set) var color: CardColor
    private(set) var shading: CardShading
}
