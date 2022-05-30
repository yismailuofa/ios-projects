//
//  EmojiMemoryGame.swift
//  memorizeGame
//
//  Created by Youssef Ismail on 2022-05-09.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let themes: [Theme] = [
        Theme(name: "Mammals", emojis: ["🐱","🐭","🐶"], numberOfPairs: 4, color: "green"),
        Theme(name: "Ocean", emojis: ["🐠","🐡","🦀"], numberOfPairs: 1, color: "blue"),
        Theme(name: "Bugs", emojis: ["🦟","🐜","🐞"], numberOfPairs: 4, color: "yellow"),
        Theme(name: "Vehicles", emojis: ["🛻","🏍","🚎"], numberOfPairs: 2, color: "orange"),
        Theme(name: "Hearts", emojis: ["💚","❤️‍🩹","❤️"], numberOfPairs: 2, color: "red"),
        Theme(name: "Sports", emojis: ["🏀","⚽️","🏈"], numberOfPairs: 3, color: "purple"),
    ]
    
    @Published private var theme: Theme<String>
    @Published private var model: MemoryGame<String>
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    init(theme: Theme) {
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    static func createMemoryGame(theme: Theme<String>) -> MemoryGame<String> {
        let clampedNumberOfPairs = min(theme.numberOfPairs, theme.emojis.count)
        
        let emojis = theme.emojis.shuffled()
        
        return MemoryGame<String>(numberOfPairs: clampedNumberOfPairs) {
            i in emojis[i]
        }
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        if (model.flip(card)) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.model.choose(card)
            }
        }
    }
    
    func getThemeForegroundColor() -> Color {
        theme.color
    }
    
    func getThemeName() -> String {
        theme.name
    }
    
    func getScore() -> Int {
        model.score
    }
}

