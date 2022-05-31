//
//  ThemeManager.swift
//  memorizeGame
//
//  Created by Youssef Ismail on 2022-05-31.
//

import SwiftUI

struct ThemeManager: View {
    @EnvironmentObject var themeChooser: ThemeChooser
    @Binding var chosenThemeIndex: Int
    @State private var editMode: EditMode = .inactive
    @Environment(\.presentationMode) var presentationMode


    var body: some View {
        NavigationView {
            List {
                ForEach(themeChooser.themes) { theme in
                    NavigationLink(destination:
                                    ThemeEditor(for: $themeChooser.themes[theme])) {
                        VStack(alignment: .leading) {
                            Text("\(theme.name): \(theme.numberOfPairs) Pairs")
                            Text(theme.emojis.joined(separator: ""))
                        }
                        .gesture(editMode == .active ? tap(for: theme) : nil)
                    }
                }
                .onDelete { indexSet in
                    themeChooser.themes.remove(atOffsets: indexSet)
                }
                .onMove { indexSet, newOffset in
                    themeChooser.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                }
            }
            .navigationTitle("Manage Themes")
            .toolbar {
                ToolbarItem { EditButton() }
                ToolbarItem(placement: .navigationBarLeading) {
                    if presentationMode.wrappedValue.isPresented,
                       UIDevice.current.userInterfaceIdiom != .pad {
                        Button("Close") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
            .environment(\.editMode, $editMode)
        }

    }
    func tap(for theme: Theme) -> some Gesture {
        TapGesture()
            .onEnded {
                if let index = themeChooser.themes.index(matching: theme) {
                    chosenThemeIndex = index
                    presentationMode.wrappedValue.dismiss()
                }
            }
    }
}
