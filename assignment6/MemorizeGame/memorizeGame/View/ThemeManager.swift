//
//  ThemeManager.swift
//  memorizeGame
//
//  Created by Youssef Ismail on 2022-05-31.
//

import SwiftUI

struct ThemeManager: View {
    @EnvironmentObject var themeChooser: ThemeChooser
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
                        .gesture(editMode == .active ? tap : nil)
                    }
                }
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
    var tap: some Gesture {
        TapGesture()
            .onEnded {
                
            }
    }
}
