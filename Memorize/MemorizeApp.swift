//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Maria Roodnitsky on 3/30/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemorizeViewModel()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
