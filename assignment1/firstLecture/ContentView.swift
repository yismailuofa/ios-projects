//
//  ContentView.swift
//  firstLecture
//
//  Created by Youssef Ismail on 2021-12-18.
//

import SwiftUI

struct ContentView: View {
    @State var emojis = ["🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🦁"]
    let animals = ["🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🦁"]
    let flags = ["🏳️","🏴","🏴‍☠️","🏁","🚩","🇪🇬","🇨🇦","🇸🇪"]
    let food = ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇"]
    @State var emojiCount = 6
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.blue)
            Spacer()
            HStack {
                animalButton
                Spacer()
                flagButton
                Spacer()
                foodButton
            }
            .font(.largeTitle)
            .padding(.horizontal)
            .foregroundColor(.blue)
        }
        .padding(.horizontal)
    }
    
    var animalButton: some View {
        VStack{
            Button {
                emojis = animals.shuffled()
            }
        label: {
            Image(systemName: "pawprint.circle.fill")
        }
            Text("Animals")
                .font(.callout)
        }
    }
    
    var flagButton: some View {
        VStack{
            Button {
                emojis = flags.shuffled()
            }
        label: {
            Image(systemName: "flag.fill")
        }
            Text("Flags")
                .font(.callout)
        }
    }
    
    var foodButton: some View {
        VStack{
            Button {
                emojis = food.shuffled()
            }
        label: {
            Image(systemName: "fork.knife.circle.fill")
        }
            Text("Food")
                .font(.callout)
        }
    }
}

struct CardView: View {
    @State var isFaceUp: Bool = true
    let content: String
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape
                    .strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape
                    .fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
