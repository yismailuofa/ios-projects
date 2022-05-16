//
//  memorizeGameApp.swift
//  memorizeGame
//
//  Created by Youssef Ismail on 2022-05-09.
//

import SwiftUI

@main
struct memorizeGameApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
