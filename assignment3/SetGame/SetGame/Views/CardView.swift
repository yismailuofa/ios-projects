//
//  CardView.swift
//  SetGame
//
//  Created by Youssef Ismail on 2022-05-16.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var model: CardViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: GraphicConstants.cardCornerRadius)
                .inset(by: GraphicConstants.cardInset)
                .stroke(model.getBorderColor(),
                        lineWidth: GraphicConstants.cardLineWidth)
            VStack {
                ForEach(0..<model.getCount(), id: \.self) {_ in
                    SymbolView(symbol: model.getSymbol(),
                               color: model.getSymbolColor(),
                               shading: model.getShading()
                    )
                }
            }
        }
        .aspectRatio(GraphicConstants.cardAspectRatio, contentMode: .fit)
        .frame(width: GraphicConstants.cardFrameWidth)
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(model: CardViewModel(Card(count: 3,
                                               symbol: .diamond,
                                               state: .unselected,
                                               color: .green,
                                               shading: .hollow
                                              )))
        }
    }
}
