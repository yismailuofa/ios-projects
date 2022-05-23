//
//  DiamondShape.swift
//  SetGame
//
//  Created by Youssef Ismail on 2022-05-18.
//

import SwiftUI

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
