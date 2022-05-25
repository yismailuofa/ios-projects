//
//  CardGameView.swift
//  SetGame
//
//  Created by Youssef Ismail on 2022-05-18.
//

import SwiftUI

struct CardGameView: View {
    @ObservedObject var model: CardGameViewModel
    @Namespace private var deckNameSpace
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 4)) {
                        ForEach(model.visibleCards) { card in
                            CardView(card: card, frameWidth: min(geometry.size.width, geometry.size.height) / 4.3)
                                .onTapGesture {
                                    model.select(card)
                                }
                                .matchedGeometryEffect(id: card.id, in: deckNameSpace)
                        }
                    }
                    .padding(.horizontal, 10)
                }
                .padding(.bottom)
            }
            
            HStack(alignment: .bottom) {
                VStack {
                    ZStack {
                        ForEach(model.allCards) { card in
                            CardView(card: card, frameWidth: 90, isFaceUp: false)
                                .matchedGeometryEffect(id: card.id, in: deckNameSpace)
                        }
                    }
                    .onTapGesture {
                        model.dealCards()
                    }
                    Text("Deck")
                }
                Spacer()
                Button {
                    withAnimation(.easeInOut(duration: GraphicConstants.selectAnimationDuration)) {
                        model.reset()
                    }
                } label: {
                    Label("New Game", systemImage: "play.circle")
                        .font(.title3)
                }
                Spacer()
                VStack {
                    ZStack {
                        if (model.discardedCards.isEmpty) {
                            Color.clear
                                .aspectRatio(GraphicConstants.cardAspectRatio, contentMode: .fit)
                                .frame(width:90)

                        } else {
                            ForEach(model.discardedCards) { card in
                                CardView(card: card, frameWidth: 90)
                                    .matchedGeometryEffect(id: card.id, in: deckNameSpace)                                
                            }
                        }

                    }
                    Text("Discard")
                }
            }
            .padding(.horizontal,7)
        }
        
    }
    
}

struct CardGameView_Previews: PreviewProvider {
    static var previews: some View {
        CardGameView(model: CardGameViewModel())
            .preferredColorScheme(.light)
    }
}
