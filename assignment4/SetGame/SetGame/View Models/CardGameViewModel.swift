//
//  CardGameViewModel.swift
//  SetGame
//
//  Created by Youssef Ismail on 2022-05-18.
//

import Foundation
import SwiftUI

class CardGameViewModel: ObservableObject {
    @Published private var cardGame: CardGame = CardGame()
    
    var visibleCards: [Card] {
        cardGame.visibleCards
    }
    
    var allCards: [Card] {
        cardGame.allCards
    }
    
    var discardedCards: [Card] {
        cardGame.discardedCards
    }
    
    var selectedCards: [Card] {
        cardGame.visibleCards.filter {$0.state == .selected || $0.state == .incorrectlySelected || $0.state == .correctlySelected}
    }
    
    func reset() {
        cardGame.reset()
    }
    
    func dealCards() {
        if (!selectedCards.isEmpty && selectedCards.allSatisfy({$0.state == .correctlySelected})) {
            select(selectedCards[0])
        }
        withAnimation(.easeInOut(duration: GraphicConstants.selectAnimationDuration)) {
            cardGame.dealCards()
        }
    }
    
    func canDeal() -> Bool {
        allCards.count >= 3
    }
    
    func select(_ card: Card) {
        let index = getIndex(card)
        let count = selectedCards.count
        
        switch count {
        case 0:
            cardGame.visibleCards[index].state = .selected
        case 1, 2:
            if (selectedCards.contains(cardGame.visibleCards[index])) {
                cardGame.visibleCards[index].state = .unselected
            } else {
                // choose the third card
                cardGame.visibleCards[index].state = .selected
                if (count == 2) {
                    let newState: Card.State = isSet() ? .correctlySelected : .incorrectlySelected
                    let cards = selectedCards
                    cards.forEach() {
                        card in
                        let index = getIndex(card)
                        cardGame.visibleCards[index].state = newState
                    }
                }
            }
        case 3:
            if (selectedCards.allSatisfy({$0.state == .correctlySelected})) {
                if (!selectedCards.contains(cardGame.visibleCards[index])) {
                    cardGame.visibleCards[index].state = .selected
                }
                
                withAnimation(.easeInOut(duration: GraphicConstants.selectAnimationDuration)) {
                    cardGame.discardedCards.append(contentsOf: cardGame.visibleCards.filter({$0.state == .correctlySelected}))
                    cardGame.visibleCards = cardGame.visibleCards.filter({$0.state != .correctlySelected})
                }
            }
            else {
                let cards = selectedCards
                cards.forEach() {
                    card in                    
                    let index = getIndex(card)
                    cardGame.visibleCards[index].state = .unselected
                }
                cardGame.visibleCards[index].state = .selected
            }
        default:
            return
        }
    }
    
    private func isSet() -> Bool {
        guard selectedCards.count == 3 else {
            return false
        }
        let enums: [[String]] = [
            selectedCards.map({$0.shading.rawValue}),
            selectedCards.map({$0.symbol.rawValue}),
            selectedCards.map({$0.color.rawValue}),
            selectedCards.map({String($0.count.rawValue)}),
        ]
        
        return enums.allSatisfy({uniformOrUnique($0)})
    }
    
    private func uniformOrUnique(_ values: [String]) -> Bool {
        let set = Set(values)
        
        return (set.count == 1) || (set.count == 3)
    }
    
    private func getIndex(_ card: Card) -> Int {
        return cardGame.visibleCards.firstIndex(where: {$0 == card})!
    }
}
