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
            RoundedRectangle(cornerRadius: 30)
                .inset(by: 10)
                .stroke(model.getBorderColor(), lineWidth: 5)
            SymbolView(for: model.getSymbol())
                .padding(20)
                .foregroundColor(model.getSymbolColor())
        }
        .aspectRatio(2/3, contentMode: .fit)
        .frame(width: 150, alignment: .center)
        
    }
    
    @ViewBuilder
    private func SymbolView(for symbol: Card.Symbols) -> some View {
        switch symbol {
        case .oval:
            Circle()
            
        case .diamond:
            Rectangle()
            
        case .rectangle:
            Rectangle()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(model: CardViewModel(Card(symbol: .oval,
                                                   count: 1,
                                                   state: .unselected,
                                                   color: .purple
                                                  )))
    }
}
