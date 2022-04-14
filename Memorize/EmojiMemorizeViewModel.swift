//
//  EmojiMemorizeViewModel.swift
//  Memorize
//
//  Created by Maria Roodnitsky on 4/6/22.
//

import SwiftUI

class EmojiMemorizeViewModel: ObservableObject {
    
    // static functions are private to the view model
        static var themeArray = [EmojiMemorizeModel<String>.Theme(name: "California", emojiArray: Array(Set(["☀️","🏄🏼‍♀️","🏝","🌉","👩‍💻","📱","🌁","😎", "🏖"])), numberOfCardPairs: 5, color: Color.blue),
                             EmojiMemorizeModel<String>.Theme(name: "Dartmouth", emojiArray: Array(Set(["🌲","🍾","🍷","📚","📘","🥂","🍻","🏓"])), numberOfCardPairs: 6, color: Color.green),
                             EmojiMemorizeModel<String>.Theme(name: "Flowers", emojiArray: Array(Set(["💐","🌼","🌸","🌷","🌺","🌻","🌹","💮", "🌱", "🌳"])), numberOfCardPairs: 11, color: Color.pink),
                             EmojiMemorizeModel<String>.Theme(name: "One", emojiArray: Array(Set(["🌳"])), numberOfCardPairs: 10, color: Color.black),
                             EmojiMemorizeModel<String>.Theme(name: "Cars", emojiArray: Array(Set(["🚙","🚕","🚓"])), numberOfCardPairs: 2, color: Color.red),
                             EmojiMemorizeModel<String>.Theme(name: "Repeat", emojiArray: Array(Set(["🌳","🌳","🌳"])), numberOfCardPairs: 2, color: Color.gray),

        ]
    
        
    static func createEmojiMemorizeModel(themeIndex: Int) -> EmojiMemorizeModel<String> {
        EmojiMemorizeModel<String>(numberOfPairsOfCards: themeArray[themeIndex].numberOfCardPairs, numberOfEmojis: themeArray[themeIndex].emojiArray.count, themeIndex: themeIndex) { pairIndex in
            if (pairIndex < themeArray[themeIndex].emojiArray.count) {
                return themeArray[themeIndex].emojiArray[pairIndex]
            } else {
                return nil
            }
        }
    }
    
    @Published private var model = createEmojiMemorizeModel(themeIndex: Int.random(in: 0..<themeArray.count))
    
    var cards: Array<EmojiMemorizeModel<String>.Card> {
        return model.cards
    }
    
    var theme: EmojiMemorizeModel<String>.Theme {
        return EmojiMemorizeViewModel.themeArray[model.themeIndex]
    }
    
    var score: Int {
        return model.score
    }
    
    func choose(_ card: EmojiMemorizeModel<String>.Card) {
        model.choose(card)
    }
        
    
    func newGame() {
        model.chooseNewTheme(numberOfThemes: EmojiMemorizeViewModel.themeArray.count)
        model = EmojiMemorizeViewModel.createEmojiMemorizeModel(themeIndex: model.themeIndex)
    }
}
