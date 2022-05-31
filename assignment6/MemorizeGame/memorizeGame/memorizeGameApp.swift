//
//  memorizeGameApp.swift
//  memorizeGame
//
//  Created by Youssef Ismail on 2022-05-09.
//

import SwiftUI

@main
struct memorizeGameApp: App {
    static let themeChooser = ThemeChooser()
    
    let game = EmojiMemoryGame(theme: themeChooser.themes.randomElement()!)
    
    var body: some Scene {
        WindowGroup {
            MemoryGameView(viewModel: game)
        }
    }
}
