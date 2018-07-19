//
//  CardDeck.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 19..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class CardDeck: CardDeckProtocol {
    
    private var cards: [Card] = []
    
    init() {
        resetCards()
    }
    
    var topCard: Card? {
        return self.cards.last
    }
    
    func resetCards() {
        var cards: [Card] = [Card]()
        for suit in Card.Suit.allCases {
            for number in Card.Number.allCases {
                cards.append(Card(suit: suit, number: number))
            }
        }
        self.cards = cards
    }
    
    // Fisher–Yates shuffle
    func shuffleCards() {
        var shuffled = [Card]()
        for count in stride(from: UInt32(self.cards.count), to: 0, by: -1) {
            shuffled.append(self.cards.remove(at: Int(arc4random_uniform(count))))
        }
        self.cards = shuffled
    }
    
    func removeTopCard() -> Card? {
        return self.cards.popLast()
    }
    
    func removeTopCards(count: Int) -> [Card] {
        var removedCards = [Card]()
        for _ in 0..<count {
            if let removedCard = removeTopCard() {
                removedCards.append(removedCard)
            }
        }
        return removedCards
    }
}

