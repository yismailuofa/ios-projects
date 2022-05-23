//
//  CardView.swift
//  SetGame
//
//  Created by Youssef Ismail on 2022-05-16.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var model: CardViewModel
    var frameWidth: CGFloat
    var onTap: () -> Void
    
    init(_ card: Card, _ width: CGFloat = GraphicConstants.cardFrameWidth, handleOnTap: @escaping () -> Void) {
        model = CardViewModel(card)
        frameWidth = width
        onTap = handleOnTap
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: frameWidth / 4)
                .inset(by: GraphicConstants.cardInset)
                .stroke(model.getBorderColor(),
                        lineWidth: frameWidth * 0.05)
            VStack {
                ForEach(0..<model.getCount(), id: \.self) {_ in
                    SymbolView(symbol: model.getSymbol(),
                               color: model.getSymbolColor(),
                               shading: model.getShading(),
                               width: frameWidth / 2
                               
                    )
                }
            }
        }
        .aspectRatio(GraphicConstants.cardAspectRatio, contentMode: .fit)
        .frame(width: frameWidth)
        .onTapGesture{
            onTap()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(Card(count: .two,
                          symbol: .diamond,
                          state: .unselected,
                          color: .green,
                          shading: .hollow
                         ),
                     handleOnTap: {}
            )
        }
    }
}
