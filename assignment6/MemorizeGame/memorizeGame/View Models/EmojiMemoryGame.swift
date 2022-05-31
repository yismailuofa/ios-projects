//
//  EmojiMemoryGame.swift
//  memorizeGame
//
//  Created by Youssef Ismail on 2022-05-09.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private var theme: Theme
    @Published private var model: MemoryGame
    
    var cards: Array<MemoryGame.Card> {
        model.cards
    }
    
    init(theme: Theme) {
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    static func createMemoryGame(theme: Theme) -> MemoryGame {
        let clampedNumberOfPairs = min(theme.numberOfPairs, theme.emojis.count)
        
        let emojis = theme.emojis.shuffled()
        
        return MemoryGame(numberOfPairs: clampedNumberOfPairs) {
            i in emojis[i]
        }
    }
    
    func choose(_ card: MemoryGame.Card) {
        if (model.flip(card)) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.model.choose(card)
            }
        }
    }
    
    func getThemeForegroundColor() -> Color {
        return Color(rgbaColor: theme.color)
    }
    
    func getThemeName() -> String {
        theme.name
    }
    
    func getScore() -> Int {
        model.score
    }
}

struct RGBAColor: Codable, Equatable, Hashable {
     let red: Double
     let green: Double
     let blue: Double
     let alpha: Double
}

extension Color {
     init(rgbaColor rgba: RGBAColor) {
     self.init(.sRGB, red: rgba.red, green: rgba.green, blue: rgba.blue, opacity: rgba.alpha)
     }
}

extension RGBAColor {
     init(color: Color) {
     var red: CGFloat = 0
     var green: CGFloat = 0
     var blue: CGFloat = 0
     var alpha: CGFloat = 0
     if let cgColor = color.cgColor {
     UIColor(cgColor: cgColor).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
     }
         
     self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
     }
}
