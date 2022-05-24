//
//  CardGameView.swift
//  SetGame
//
//  Created by Youssef Ismail on 2022-05-18.
//

import SwiftUI

struct CardGameView: View {
    @ObservedObject var model: CardGameViewModel
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 2) {
                Button {
                    model.dealCards()
                } label: {
                    Label("Deal", systemImage: "plus.rectangle.portrait")
                        .font(.title3)
                }
                .disabled(!model.canDeal())
                Spacer()
                Button {
                    withAnimation(.easeInOut(duration: GraphicConstants.selectAnimationDuration)) {
                        model.reset()
                    }
                } label: {
                    Label("New Game", systemImage: "play.circle")
                        .font(.title3)
                }
            }
            .padding(.horizontal)
            
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 4)) {
                        ForEach(model.visibleCards) { card in
                            CardView(card: card, frameWidth: min(geometry.size.width, geometry.size.height) / 4.3)
                                .onTapGesture {
                                    model.select(card)
                                }
                        }
                    }
                    .padding(.horizontal, 10)
                }
            }
            .padding(.bottom,1)
            HStack {
                Text("Deck")
                Spacer()
                Text("Discard")
            }
            .padding(10)
        }
        
    }
    
}

struct CardGameView_Previews: PreviewProvider {
    static var previews: some View {
        CardGameView(model: CardGameViewModel())
    }
}
