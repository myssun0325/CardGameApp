//
//  CardDeck.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 19..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class CardDeck {
    private var cards: [Card] = []
    
    init(_ cards: [Card]) {
        self.cards = cards
    }
    
    init() {
        reset()
    }
    
    var topCard: Card? {
        return cards.last
    }
    
    func reset() {
        var cards: [Card] = [Card]()
        for suit in Card.Suit.allCases {
            for number in Card.Number.allCases {
                cards.append(Card(suit: suit, number: number))
            }
        }
        self.cards = cards
        self.shuffleCards()
    }
    
    // Fisher–Yates shuffle
    private func shuffleCards() {
        var shuffled = [Card]()
        for count in stride(from: UInt32(self.cards.count), to: 0, by: -1) {
            shuffled.append(self.cards.remove(at: Int(arc4random_uniform(count))))
        }
        self.cards = shuffled
    }
    
    func popTopCard() -> Card? {
        guard let topCard = self.cards.popLast() else { return nil }
        return topCard
    }
    
    func push(cards: [Card]) {
        self.cards.append(contentsOf: cards)
    }
}
