//
//  ThemeChooser.swift
//  memorizeGame
//
//  Created by Youssef Ismail on 2022-05-30.
//

import SwiftUI

class ThemeChooser: ObservableObject {
    static let THEMES_KEY = "themes"
    
    @Published var themes = [Theme]() {
        didSet {
            let oldThemes = oldValue.difference(from: themes)
            let newThemes = themes.difference(from: oldValue)
             
            oldThemes.forEach { theme in
                themeToGame[theme] = nil                
            }
            newThemes.forEach { theme in
                themeToGame[theme] = EmojiMemoryGame(theme: theme)
            }
            
            storeInUserDefaults()
        }
    }
    var themeToGame: [Theme: EmojiMemoryGame] = [:]
    
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: ThemeChooser.THEMES_KEY)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: ThemeChooser.THEMES_KEY),
           let decodedThemes = try? JSONDecoder().decode([Theme].self, from: jsonData) {
            themes = decodedThemes
        }
    }
    
    init() {
//        restoreFromUserDefaults()
        
        if (themes.isEmpty) {
            insertTheme(named: "Sports", emojis: "🏈⚾️🏀⚽️🎾🏐🥏🏓⛳️🥅🥌🏂⛷🎳".map({String($0)}), numberOfPairs: 8, color: RGBAColor(color: Color(uiColor: .orange)))
            insertTheme(named: "Vehicles", emojis: "🚙🚗🚘🚕🚖🏎🚚🛻🚛🚐🚓🚔🚑🚒🚀✈️🛫🛬🛩🚁🛸🚲🏍🛶⛵️🚤🛥🛳⛴🚢🚂🚝🚅🚆🚊🚉🚇🛺🚜".map({String($0)}), numberOfPairs: 8, color: RGBAColor(color: Color(uiColor: .blue)))
            insertTheme(named: "Animals", emojis: "🐵🙈🙊🙉🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐷🐸🐲".map({String($0)}), numberOfPairs: 8, color: RGBAColor(color: Color(uiColor: .green)))
        }
        
        themes.forEach { theme in
            themeToGame[theme] = EmojiMemoryGame(theme: theme)
        }
    }
    
    func gameModel(at index: Int) -> EmojiMemoryGame {
        let theme = theme(at: index)
        return themeToGame[theme]!
    }
    
    func theme(at index: Int) -> Theme {
        let safeIndex = min(max(index, 0), themes.count - 1)
        return themes[safeIndex]
    }
    
    @discardableResult
    func removeTheme(at index: Int) -> Int {
        if themes.count > 1, themes.indices.contains(index) {
            themes.remove(at: index)
        }
        return index % themes.count
    }
    
    func insertTheme(named name: String, emojis: [String] = [String](), numberOfPairs: Int, color: RGBAColor, at index: Int = 0) {
        let unique = (themes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let theme = Theme(name: name, emojis: emojis, numberOfPairs: numberOfPairs, color: color, id: unique)
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(theme, at: safeIndex)
        themeToGame[theme] = EmojiMemoryGame(theme: theme)
    }
}

