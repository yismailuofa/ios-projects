//
//  CardGameView.swift
//  SetGame
//
//  Created by Youssef Ismail on 2022-05-18.
//

import SwiftUI

struct CardGameView: View {
    @ObservedObject var model: CardGameViewModel
    @State var count = 12
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 2) {
                Button {
                    count += 3
                } label: {
                    Label("Deal 3 More Cards", systemImage: "plus.rectangle.portrait")
                }
                Text("\(model.selectedCards.count)")
                Spacer()
            }
            .padding()
            
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 4)) {
                        ForEach(model.getCards()[0..<count], id: \.description) { card in
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
