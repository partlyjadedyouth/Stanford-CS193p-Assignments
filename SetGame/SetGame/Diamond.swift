//
//  Diamond.swift
//  SetGame
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let height = rect.height
        let width = rect.width
        let start = CGPoint(x: center.x + width / 2, y: center.y)
        
        var p = Path()
        p.move(to: start)
        p.addLine(to: CGPoint(x: center.x, y: center.y + height / 2))
        p.addLine(to: CGPoint(x: center.x - width / 2, y: center.y))
        p.addLine(to: CGPoint(x: center.x, y: center.y - height / 2))
        p.addLine(to: CGPoint(x: center.x + width / 2, y: center.y))
        
        return p
    }
}
