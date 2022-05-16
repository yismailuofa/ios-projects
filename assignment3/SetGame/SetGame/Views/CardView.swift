//
//  CardView.swift
//  SetGame
//
//  Created by Youssef Ismail on 2022-05-16.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .inset(by: 10)
                .stroke(.gray, lineWidth: 5)
        }
        .aspectRatio(2/3, contentMode: .fit)
        .frame(width: 150, alignment: .center)
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(symbol: .oval, count: 1, state: .unselected))
    }
}
