//
//  CardGameViewModel.swift
//  SetGame
//
//  Created by Youssef Ismail on 2022-05-18.
//

import Foundation
import SwiftUI

class CardGameViewModel: ObservableObject {
    @Published private var cardGame: CardGame
    var selectedCards: [Card] {
        cardGame.cards.filter {$0.state == .selected}
    }
    
    init() {
        cardGame = CardGame()
    }
    
    func getCards() -> [Card] {
        cardGame.cards
    }
    
    func select(_ card: Card) {
        let index = cardGame.cards.firstIndex(where: {$0 == card})!
        let count = selectedCards.count
        
        switch count {
        case 0:
            cardGame.cards[index].state = .selected
        case 1, 2:
            if (selectedCards.contains(cardGame.cards[index])) {
                cardGame.cards[index].state = .unselected
            } else {
                cardGame.cards[index].state = .selected
            }
        case 3:
            break
        default:
            return
        }
    }
    
    private func isSet() -> Bool {
        guard selectedCards.count == 3 else {
            return false
        }
        let enums: [[String]] = [
            Card.Shading.allCases.map({$0.rawValue}),
            Card.Symbols.allCases.map({$0.rawValue}),
            Card.Color.allCases.map({$0.rawValue}),
            Card.Count.allCases.map({String($0.rawValue)}),
        ]
        
        return enums.allSatisfy({uniformOrUnique($0)})
    }
    
    private func uniformOrUnique(_ values: [String]) -> Bool {
        let set = Set(values)
        
        return set.count == 1 || set.count == 3
    }
}
