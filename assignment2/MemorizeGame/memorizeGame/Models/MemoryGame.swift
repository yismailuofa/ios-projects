//
//  MemoryGame.swift
//  memorizeGame
//
//  Created by Youssef Ismail on 2022-05-09.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    private var faceUpIndex: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id})
        {
            if let potentialMatchIndex = faceUpIndex {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                }
                else {
                    if (cards[potentialMatchIndex].isSeen) {score -= 1} else {cards[potentialMatchIndex].isSeen = true}
                    if (cards[chosenIndex].isSeen) {score -= 1} else {cards[chosenIndex].isSeen = true}
                    
                    cards[potentialMatchIndex].isFaceUp = false
                    cards[chosenIndex].isFaceUp = false
                }
                faceUpIndex = nil
            } else {
                faceUpIndex = chosenIndex
            }
        }
    }
    
    mutating func flip(_ card: Card) -> Bool {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched
        {
            cards[chosenIndex].isFaceUp = true
            return true
        }
        else {
            return false
        }
    }
    
    init(numberOfPairs: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for i in 0..<numberOfPairs {
            let content = createCardContent(i)
            cards.append(Card(content: content, id: i*2))
            cards.append(Card(content: content, id: i*2 + 1))
        }
        
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isSeen: Bool = false
        var content: CardContent
        var id: Int
    }
}
