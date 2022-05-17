//
//  CardViewModel.swift
//  SetGame
//
//  Created by Youssef Ismail on 2022-05-16.
//

import Foundation
import SwiftUI

class CardViewModel: ObservableObject {
    @Published private var card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    func getBorderColor() -> Color {
        switch card.state {
        case .unselected:
            return .gray
            
        case .correctlySelected:
            return .green
            
        case .incorrectlySelected:
            return .red
            
        case .selected:
            return .blue
        }
    }
    
    func getSymbolColor() -> Color {
        switch card.color {
        case .red:
            return .red
            
        case .green:
            return .green
            
        case .purple:
            return .purple
        }
    }
    
    func getSymbol() -> Card.Symbols {
        card.symbol
    }
}
