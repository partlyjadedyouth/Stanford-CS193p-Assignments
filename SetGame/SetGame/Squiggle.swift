//
//  Squiggle.swift
//  SetGame
//
//  Created by Jun_MacBookPro on 2022/09/01.
//

import SwiftUI

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        let sineWidth: CGFloat = 0.8
        let sineAmp: CGFloat = 0.3
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let height = rect.height
        let width = rect.width
        let origin = CGPoint(x: center.x - width / 2, y: center.y - height / 2)
        
        var p = UIBezierPath()
        
        p.move(to: origin)
        
        
        return p
    }
    
    
}
