//
//  EmojiMemorizeModel.swift
//  Memorize
//
//  Created by Maria Roodnitsky on 4/6/22.
//

import Foundation
import SwiftUI

struct EmojiMemorizeModel<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var themeIndex: Int
    private var indexOfFaceUpCard: Int? {
        get { cards.indices.filter( {cards[$0].isFaceUp}).oneAndOnly }
        set { cards.indices.forEach {cards[$0].isFaceUp = ($0 == newValue)} }
    }
    
    private(set) var score: Int = 0
    
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    } else {
                        if (cards[chosenIndex].seen) { score -= 1}
                        if (cards[potentialMatchIndex].seen) { score -= 1}
                    }
                    cards[chosenIndex].seen = true
                    cards[potentialMatchIndex].seen = true
                    cards[chosenIndex].isFaceUp = true
                } else {
                    indexOfFaceUpCard = chosenIndex
                }
        }
    }
    
    mutating func chooseNewTheme(numberOfThemes: Int) {
        themeIndex = Int.random(in: 0..<numberOfThemes)
    }
    
    init(numberOfPairsOfCards: Int, numberOfEmojis: Int, themeIndex: Int, createCardContent: (Int) -> CardContent?) {
        cards = []
        self.themeIndex = themeIndex
        var randomOrder = Array(0..<numberOfEmojis)
        randomOrder.shuffle()
        
        if (numberOfPairsOfCards < numberOfEmojis) {
            randomOrder = Array(randomOrder[0...numberOfPairsOfCards - 1])
        }
        
        
        for pairIndex in randomOrder {
            // a function is passed in that creates the content for the card
            if let content = createCardContent(pairIndex) {
                cards.append(Card(content: content, id: pairIndex * 2))
                cards.append(Card(content: content, id: pairIndex * 2 + 1))
            }
        }
        
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var seen = false
        let content: CardContent
        let id: Int
    }
    
    struct Theme {
        var name: String
        var emojiArray: Array<String>
        var numberOfCardPairs: Int
        var color: Color
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
