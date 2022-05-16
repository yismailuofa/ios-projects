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
    
    init() {
        let randomTheme = EmojiMemoryGame.themes.randomElement()!
        
        theme = randomTheme
        model = EmojiMemoryGame.createMemoryGame(theme: randomTheme)
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
        switch theme.color {
        case "green":
            return Color.green
        case "blue":
            return Color.blue
        case "yellow":
            return Color.yellow
        case "orange":
            return Color.orange
        case "red":
            return Color.red
        case "purple":
            return Color.purple
        default:
            return Color.accentColor
        }
    }
    
    func getThemeName() -> String {
        theme.name
    }
    
    func startNewGame() {
        let randomTheme = EmojiMemoryGame.themes.randomElement()!
        
        theme = randomTheme
        model = EmojiMemoryGame.createMemoryGame(theme: randomTheme)
    }
    
    func getScore() -> Int {
        model.score
    }
}

