//
//  CardStack.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 20..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class CardStack: IteratorProtocol, Sequence {
    private var cards: [Card] = []
    
    init(_ cards: [Card]) {
        self.cards = cards
    }
    
    var count: Int {
        return self.cards.count
    }
    
    var topCard: Card? {
        return cards.last
    }
    
    func reset() {
        self.cards.removeAll()
    }
    
    func push(card: Card) {
        self.cards.append(card)
    }
    
    func isNextCard(_ nextCard: Card) -> Bool {
        guard let topCard = self.cards.last else { return false }
        return topCard.isNextCardInCardStack(nextCard)
    }
    
    func isEmpty() -> Bool {
        return cards.count == 0
    }
    
    func popTopCard() -> Card? {
        guard let topCard = self.cards.popLast() else { return nil }
        self.cards.last?.open()
        return topCard
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
