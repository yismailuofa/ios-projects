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
    let shading: Card.Shading
    var frameWidth: CGFloat
    
    init(
        symbol: Card.Symbols,
        color: Color,
        shading: Card.Shading,
        width: CGFloat = GraphicConstants.symbolFrameWidth) {
            frameWidth = width
            self.symbol = symbol
            self.color = color
            self.shading = shading
        }
    
    var body: some View {
        colorShape()
            .aspectRatio(GraphicConstants.symbolAspectRatio, contentMode: .fit)
            .frame(width: frameWidth)
    }
    
    @ViewBuilder
    func colorShape() -> some View {
        let shape = shape(from: symbol)
        
        switch shading {
        case .filled:
            shape
                .foregroundColor(color)
        case .hollow:
            shape
                .stroke(color, lineWidth: GraphicConstants.symbolLineWidth)
        case .striped:
            shape
                .foregroundColor(color)
                .opacity(GraphicConstants.symbolStripedOpacity)
        }
    }
    
    func shape(from symbol: Card.Symbols) -> some Shape {
        switch symbol {
        case .oval:
            return AnyShape(RoundedRectangle(cornerRadius: GraphicConstants.ovalSymbolCornerRadius))
        case .diamond:
            return AnyShape(DiamondShape())
        case .rectangle:
            return AnyShape(Rectangle())
        }
    }
}
