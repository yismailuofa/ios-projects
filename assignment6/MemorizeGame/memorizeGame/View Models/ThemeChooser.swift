//
//  ThemeChooser.swift
//  memorizeGame
//
//  Created by Youssef Ismail on 2022-05-30.
//

import SwiftUI

class ThemeChooser: ObservableObject {
    static let THEMES_KEY = "themes"
    var themes = [Theme]() {
        didSet {
            storeInUserDefaults()
        }
    }
    
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
        print(themes)
    }
    
//    @discardableResult
//    func removePalette(at index: Int) -> Int {
//        if palettes.count > 1, palettes.indices.contains(index) {
//            palettes.remove(at: index)
//        }
//        return index % palettes.count
//    }
    
    func insertTheme(named name: String, emojis: [String] = [String](), numberOfPairs: Int, color: RGBAColor, at index: Int = 0) {
        let unique = (themes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let theme = Theme(name: name, emojis: emojis, numberOfPairs: numberOfPairs, color: color, id: unique)
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(theme, at: safeIndex)
    }
}
