//
//  SetGame.swift
//  SetGame
//

import Foundation

struct SetGame {
    private(set) var deck: [Card]
    private(set) var table: [Card]  // Cards set on the table
    // Keep tracking the indices of selected cards by using a computed property
    private var indicesOfSelectedCards: [Int] { table.indices.filter({ table[$0].isSelected }) }
    
    // Initializer
    init() {
        deck = [Card]()
        table = [Card]()
    }
    
    // Determine whether there are cards which form a "set" on the table.
    // Must be called only when indicesOfSelectedCards.count == 3
    private func areMatched(in table: [Card]) -> Bool {
        if indicesOfSelectedCards.count == 3 {
            let card1 = table[indicesOfSelectedCards[0]]
            let card2 = table[indicesOfSelectedCards[1]]
            let card3 = table[indicesOfSelectedCards[2]]
            
            let isNumberSet = ((card1.number == card2.number) && (card1.number == card3.number)) || ((card1.number != card2.number) && (card2.number != card3.number) && (card3.number != card1.number))
            let isShapeSet = ((card1.shape == card2.shape) && (card1.shape == card3.shape)) || ((card1.shape != card2.shape) && (card2.shape != card3.shape) && (card3.shape != card1.shape))
            let isShadingSet = ((card1.shading == card2.shading) && (card1.shading == card3.shading)) || ((card1.shading != card2.shading) && (card2.shading != card3.shading) && (card3.shading != card1.shading))
            let isColorSet = ((card1.color == card2.color) && (card1.color == card3.color)) || ((card1.color != card2.color) && (card2.color != card3.color) && (card3.color != card1.color))
        
            return isNumberSet && isShapeSet && isShadingSet && isColorSet
        } else {
            return false
        }
        
    }
    
    // Called when the card is touched
    mutating func select(_ card: Card) {
        // If there are already 3 selected cards on the table, call 'areMatched' and replace/deselect them.
        if indicesOfSelectedCards.count == 3 {
            if areMatched(in: table) {
                replaceCards()
            }
            indicesOfSelectedCards.forEach({
                table[$0].isSelected = false
                table[$0].isSet = nil
            })
        }
        
        // If the selected card was part of the set, select nothing.
        // Else, (de)select the card.
        if let chosenIndex = table.firstIndex(where: { $0.id == card.id }) {
            table[chosenIndex].isSelected.toggle()  // Works on both selection and deselection
            // If 3 cards were chosen, call 'areMatched'
            if indicesOfSelectedCards.count == 3 {
                let isMatched = areMatched(in: table)
                indicesOfSelectedCards.forEach({
                    table[$0].isSet = isMatched
                })
            }
        }
    }
    
    // Replace the cards into the new ones
    private mutating func replaceCards() {
        indicesOfSelectedCards.forEach({ i in
            table.remove(at: i)
            // if the deck is empty, do nothing
            if !deck.isEmpty {
                table.insert(deck.popLast()!, at: i)
            }
        })
    }
    
    // Called when the button is touched.
    mutating func dealThreeMoreCards() {
        if indicesOfSelectedCards.count == 3 && areMatched(in: table) {
            replaceCards()
        } else {
            let numberOfNewCards = min(3, deck.count)
            for _ in 0..<numberOfNewCards {
                table.append(deck.popLast()!)
            }
        }
    }
    
    // Called when the button is touched.
    mutating func newGame() {
        deck = [Card]()
        table = [Card]()
        
        var i = 0
        Card.Shape.allCases.forEach({ shape in
            Card.Shading.allCases.forEach({ shading in
                Card.Color.allCases.forEach({ color in
                    for number in 1...3 {
                        deck.append(Card(number: number, shape: shape, shading: shading, color: color, id: i))
                        i += 1
                    }
                })
            })
        })
        deck.shuffle()
        
        for _ in 0..<12 {
            table.append(deck.popLast()!)
        }
    }
}
