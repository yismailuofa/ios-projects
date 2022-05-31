//
//  ThemeEditor.swift
//  memorizeGame
//
//  Created by Youssef Ismail on 2022-05-30.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme
    @State private var emojiToAdd = ""
    @State private var color: Color
    
    init(for theme: Binding<Theme>) {
        self._theme = theme
        color = Color(rgbaColor: theme.color.wrappedValue)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Name", text: $theme.name)
            }
            Section(header: Text("Number of Pairs")) {
                Stepper(value: $theme.numberOfPairs, in: 1...theme.emojis.count) {
                    Text("Value: \(theme.numberOfPairs)")
                }
            }
            Section(header: Text("Card Color")) {
                ColorPicker("Choose a color! 🎨", selection: $color)
                    .onChange(of: color) { color in 
                        theme.color = RGBAColor(color: color)
                    }
            }
            Section(header: Text("Add Emoji")) {
                TextField("", text: $emojiToAdd)
                    .onSubmit {
                        withAnimation {
                            if emojiToAdd.count == 1 {
                                theme.emojis = [emojiToAdd] + theme.emojis
                            }
                            emojiToAdd = ""
                        }
                    }
            }
            Section(header: Text("Emoji")) {
                List {
                    ForEach(theme.emojis, id: \.self) { emoji in
                        Text("\(emoji)")
                    }
                    .onDelete { indexSet in
                        theme.emojis.remove(atOffsets: indexSet)
                    }
                }
            }
        }
        .navigationTitle("Edit \(theme.name)")
        .frame(minWidth: 300, minHeight: 500)
    }

}
