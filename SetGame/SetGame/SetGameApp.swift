//
//  SetGameApp.swift
//  SetGame
//

import SwiftUI

@main
struct SetGameApp: App {
    var body: some Scene {
        WindowGroup {
            SetGameView(setGame: BasicSetGame())
        }
    }
}
