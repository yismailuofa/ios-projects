//
//  CardGame.swift
//  SetGame
//
//  Created by Youssef Ismail on 2022-05-18.
//

import Foundation

struct CardGame {
    var cards = Array<Card>()
    var visibleCards = Array<Card>()
    
    init() {
        setCards()
    }
    
    mutating func setCards() {
        cards = CardGame.generateAllCards()
        cards.shuffle()
        
        visibleCards.removeAll()
        for _ in 0..<12 {
            visibleCards.append(cards.popLast()!)
        }
    }
    
    mutating func dealCards() {
        for _ in 0..<3 {
            visibleCards.append(cards.popLast()!)
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
        return cards
    }
}
