//
//  Card.swift
//  SetGame
//

import Foundation

struct Card: Identifiable {
    // Card features
    var number: Int
    var shape: Shape
    var shading: Shading
    var color: Color
    
    var isSelected = false
    var isSet: Bool?
    var id: Int
    
    // Enums to describe card features
    enum Shape: CaseIterable {
        case diamond, rectangle, oval
    }
    
    enum Shading: CaseIterable {
        case solid, striped, open
    }
    
    enum Color: CaseIterable {
        case purple, orange, brown
    }
}
