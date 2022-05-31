//
//  memorizeGameApp.swift
//  memorizeGame
//
//  Created by Youssef Ismail on 2022-05-09.
//

import SwiftUI

@main
struct memorizeGameApp: App {
    @StateObject var themeChooser = ThemeChooser()
        
    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(themeChooser)
        }
    }
}
