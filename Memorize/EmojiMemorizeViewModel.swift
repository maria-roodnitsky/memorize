//
//  EmojiMemorizeViewModel.swift
//  Memorize
//
//  Created by Maria Roodnitsky on 4/6/22.
//

import SwiftUI

class EmojiMemorizeViewModel {
    
    // static functions are private to the view model
    static let emojis =  ["💐","🌼","🌸","🌷","🌺","🌻","🌹","💮", "🌱", "🌳"]
    
    static func createEmojiMemorizeModel() -> EmojiMemorizeModel<String> {
        EmojiMemorizeModel<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    private var model = createEmojiMemorizeModel()
    
    var cards: Array<EmojiMemorizeModel<String>.Card> {
        return model.cards
    }
}
