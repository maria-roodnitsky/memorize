//
//  EmojiMemorizeModel.swift
//  Memorize
//
//  Created by Maria Roodnitsky on 4/6/22.
//

import Foundation

struct EmojiMemorizeModel<CardContent> {
    private(set) var cards: Array<Card>
    
    func choose(_ card: Card) { }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            // a function is passed in that creates the content for the card
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    struct Card {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
    }
}
