//
//  CardView.swift
//  SetGame
//
//  Created by Youssef Ismail on 2022-05-16.
//

import SwiftUI

struct CardView: View {
    var card: Card
    var frameWidth: CGFloat
    var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            if isFaceUp {
                Group {
                    RoundedRectangle(cornerRadius: frameWidth / 4)
                        .inset(by: GraphicConstants.cardInset)
                        .strokeBorder(getBorderColor(card.state),
                                lineWidth: frameWidth * 0.05)
                        .background(.white)
                        .animation(.easeInOut(duration: GraphicConstants.selectAnimationDuration), value: card.state)
                    VStack {
                        ForEach(0..<card.count.rawValue, id: \.self) {_ in
                            SymbolView(symbol: card.symbol,
                                       color: getSymbolColor(card.color),
                                       shading: card.shading,
                                       width: frameWidth / 2
                                       
                            )
                        }
                    }
                }

            }
            else {
                RoundedRectangle(cornerRadius: frameWidth / 4)
                    .inset(by: GraphicConstants.cardInset)
                    .fill(.gray)
            }

        }
        .aspectRatio(GraphicConstants.cardAspectRatio, contentMode: .fit)
        .frame(width: frameWidth)
    }
    
    private func getBorderColor(_ state: Card.State) -> Color {
        switch state {
        case .unselected:
            return .gray
            
        case .correctlySelected:
            return .green
            
        case .incorrectlySelected:
            return .red
            
        case .selected:
            return .blue
            
        default:
            return .clear
        }
    }
    
    private func getSymbolColor(_ color: Card.Color) -> Color {
        switch color {
        case .red:
            return .red
            
        case .green:
            return .green
            
        case .purple:
            return .purple
        }
    }
}
//
//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            CardView(
//                card: Card(count: .two,
//                           symbol: .diamond,
//                           state: .unselected,
//                           color: .green,
//                           shading: .hollow
//                          ),
//                frameWidth: 90
//            )
//        }
//    }
//}
