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
    
    var symbol: Symbols
    var count: Int
    var state: CardState 
}
