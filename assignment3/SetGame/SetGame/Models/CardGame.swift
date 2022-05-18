//
//  CardGame.swift
//  SetGame
//
//  Created by Youssef Ismail on 2022-05-18.
//

import Foundation

struct CardGame {
    var cards: [Card]
    
    init() {
        cards = []
        
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
    }
}
