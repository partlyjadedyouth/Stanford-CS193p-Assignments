//
//  BasicSetGame.swift
//  SetGame
//
//  "VIEWMODEL"

import SwiftUI

class BasicSetGame: ObservableObject {
    private static func createSetGame() -> SetGame {
        var setGame = SetGame()
        setGame.newGame()
        return setGame
    }
    
    @Published private var model: SetGame = createSetGame()
    
    // MARK: - Exposing private var model to my View
    var deck: [Card] { model.deck }
    var table: [Card] { model.table }
    
    // MARK: - Functions related to user intents
    func select(_ card: Card) { model.select(card) }
    func dealThreeMoreCards() { model.dealThreeMoreCards() }
    func newGame() { model.newGame() }
}

