//
//  AppView.swift
//  memorizeGame
//
//  Created by Youssef Ismail on 2022-05-30.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject var themeChooser: ThemeChooser
    @State private var chosenThemeIndex: Int = 0
    @State private var themeToEdit: Theme?
    @State private var managing = false

    var body: some View {
        VStack {
            MemoryGameView(viewModel: themeChooser.gameModel(at: chosenThemeIndex))
            themeContext
                .popover(item: $themeToEdit) { theme in
                    ThemeEditor(for: $themeChooser.themes[theme])
                }
                .sheet(isPresented: $managing) {
                    ThemeManager(chosenThemeIndex: $chosenThemeIndex)
                }
        }
    }
    
    var themeContext: some View {
        HStack {
            Spacer()
            Menu {
                contextMenu
            } label: {
                Label("Themes", systemImage: "eyedropper")
            }
            
        }
        .padding()
    }
    
    
    @ViewBuilder
    var contextMenu: some View {
        AnimatedActionButton(title: "Edit", systemImage: "pencil") {
            themeToEdit = themeChooser.theme(at: chosenThemeIndex)
        }
        AnimatedActionButton(title: "New", systemImage: "plus") {
            themeChooser.insertTheme(named: "New Theme", emojis: ["🤠"], numberOfPairs: 1, color: RGBAColor(color: Color(uiColor: .red)), at: chosenThemeIndex)
            themeToEdit = themeChooser.theme(at: chosenThemeIndex)
        }
        AnimatedActionButton(title: "Delete", systemImage: "minus.circle") {
            chosenThemeIndex = themeChooser.removeTheme(at: chosenThemeIndex)
        }
        AnimatedActionButton(title: "Manage", systemImage: "slider.vertical.3") {
            managing = true
        }
        Menu {
            ForEach (themeChooser.themes) { theme in
                AnimatedActionButton(title: theme.name) {
                    if let index = themeChooser.themes.index(matching: theme) {
                        chosenThemeIndex = index
                    }
                }
            }
        } label: {
            Label("Select", systemImage: "text.insert")
        }
    }
}

struct AnimatedActionButton: View {
    var title: String? = nil
    var systemImage: String? = nil
    let action: () -> Void
    
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            if title != nil && systemImage != nil {
                Label(title!, systemImage: systemImage!)
            } else if title != nil {
                Text(title!)
            } else if systemImage != nil {
                Image(systemName: systemImage!)
            }
        }
    }
}
