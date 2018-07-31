//
//  CardDeck.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 19..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class CardDeck: IteratorProtocol, Sequence {
    private var cards: [Card] = []
    
    func fillDefaultShuffledCards() {
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
    
    func push(card: Card) {
        self.cards.append(card)
    }
    
    func allCards() -> [Card] {
        return self.cards
    }
    
    // Iterator, Sequence
    private var index: Int = 0
    func next() -> Card? {
        if index < self.cards.endIndex {
            defer { index = self.cards.index(after: index) }
            return self.cards[index]
        } else {
            self.index = 0
            return nil
        }
    }
}
