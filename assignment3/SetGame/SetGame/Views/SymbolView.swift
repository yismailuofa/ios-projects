//
//  SymbolView.swift
//  SetGame
//
//  Created by Youssef Ismail on 2022-05-17.
//

import SwiftUI

struct SymbolView: View {
    let symbol: Card.Symbols
    let color: Color
    
    var body: some View {
        SymbolShapeView(symbol: symbol, color: color)
            .frame(width: 50)
    }
}

struct SymbolShapeView: View {
    let symbol: Card.Symbols
    let color: Color

    var body: some View {
            switch symbol {
            case .oval:
                RoundedRectangle(cornerRadius: 40)
                    .aspectRatio(3/2, contentMode: .fit)
                    .foregroundColor(color)
                
            case .diamond:
                DiamondShape()
                    .stroke(color, lineWidth: 3)
                    .aspectRatio(3/2, contentMode: .fit)
                
            case .rectangle:
                Rectangle()
                    .aspectRatio(3/2, contentMode: .fit)
                    .foregroundColor(color)
            }

    }
}

struct DiamondShape: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let (horizontal, vertical) = (rect.width / 2, rect.width / 4)
        
        return Path() { path in
            path.move(to: CGPoint(
                x: center.x,
                y: center.y - vertical
            ))
            path.addLine(to: CGPoint(
                x: center.x - horizontal,
                y: center.y
            ))
            path.addLine(to: CGPoint(
                x: center.x,
                y: center.y + vertical
            ))
            path.addLine(to: CGPoint(
                x: center.x + horizontal,
                y: center.y
            ))
            path.addLine(to: CGPoint(
                x: center.x,
                y: center.y - vertical
            ))
            path.closeSubpath()
        }
    }
}
