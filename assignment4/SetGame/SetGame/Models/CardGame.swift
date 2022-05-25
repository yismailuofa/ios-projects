//
//  CardGame.swift
//  SetGame
//
//  Created by Youssef Ismail on 2022-05-18.
//

import Foundation

struct CardGame {
    var allCards = Array<Card>()
    var visibleCards = Array<Card>()
    var discardedCards = Array<Card>()
    
    init() {
        reset()
    }
    
    mutating func reset() {
        allCards = CardGame.generateAllCards()
        
        visibleCards.removeAll()
        discardedCards.removeAll()
        
        for _ in 0..<12 {
            visibleCards.append(allCards.popLast()!)
        }
    }
    
    mutating func dealCards() {
        for _ in 0..<3 {
            visibleCards.append(allCards.popLast()!)
        }
    }
    
    static func generateAllCards() -> [Card] {
        var cards = Array<Card>()
        
        for symbol in Card.Symbols.allCases {
            for color in Card.Color.allCases {
                for shading in Card.Shading.allCases {
                    for count in Card.Count.allCases {
                        cards.append(Card(count: count,
                                          symbol: symbol,
                                          state: .unselected,
                                          color: color,
                                          shading: shading))
                    }
                }
            }
        }
        cards.shuffle()
        
        return cards
    }
}
