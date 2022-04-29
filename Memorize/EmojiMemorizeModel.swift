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
    
    mutating func shuffle() {
        cards.shuffle()
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
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var seen = false
        let content: CardContent
        let id: Int
        
        // MARK: - Bonus Time
        
        // this could give matching bonus points
        // if the user matches the card
        // before a certain amount of time passes during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
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
