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
                    model.setCards()
                } label: {
                    Label("New Game", systemImage: "play.circle")
                        .font(.title3)
                }
            }
            .padding()
            
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 4)) {
                        ForEach(model.getCards(), id: \.description) { card in
                            CardView(card, geometry.size.width / 4) {
                                model.select(card)
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                }
            }
            .padding(.bottom,1)
        }
    }
    
}

struct CardGameView_Previews: PreviewProvider {
    static var previews: some View {
        CardGameView(model: CardGameViewModel())
            .previewInterfaceOrientation(.portrait)
    }
}
