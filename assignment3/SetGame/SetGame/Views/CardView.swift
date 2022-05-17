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
            
            SymbolView(symbol: model.getSymbol(), color: model.getSymbolColor())
        }
        .aspectRatio(2/3, contentMode: .fit)
        .frame(width: 150)
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(model: CardViewModel(Card(symbol: .diamond,
                                           count: 1,
                                           state: .selected,
                                           color: .red
                                      )))
    }
}
