//
//  MemoryGameView.swift
//  memorizeGame
//
//  Created by Youssef Ismail on 2022-05-09.
//

import SwiftUI

struct MemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            HStack(alignment: .center ) {
                Button {
                    viewModel.restart()
                }
                label: {
                    Label("New Game", systemImage: "play.circle")
                }
                Spacer()
                Text("Score: \(viewModel.getScore())")
            }
            .padding()
            
            Text(viewModel.getThemeName())
                .font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) {
                        card in CardView(card: card).aspectRatio(2/3, contentMode: .fit).onTapGesture {
                            withAnimation {
                                viewModel.choose(card)
                            }
                        }
                    }
                }
            }
            .foregroundColor(viewModel.getThemeForegroundColor())
            .padding(.horizontal)
        }
    }
}

struct CardView: View {
    let card: MemoryGame.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
                if card.isMatched {
                    shape.opacity(0.25)
                }
            } else {
                shape.fill()
            }
        }
    }
}
