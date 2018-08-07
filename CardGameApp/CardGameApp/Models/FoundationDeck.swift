//
//  FoundationDeck.swift
//  CardGameApp
//
//  Created by moon on 2018. 8. 6..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class FoundationDeck: IteratorProtocol, Sequence {
    private var cards: [Card] = []
    
    func reset() {
        self.cards.removeAll()
    }
    
    func isEmpty() -> Bool {
        return self.cards.count == 0
    }
    
    func push(card: Card) {
        self.cards.append(card)
    }
    
    func isNextCard(_ nextCard: Card) -> Bool {
        guard let topCard = self.cards.last else { return false }
        return topCard.isNextCardInFoundationDeck(nextCard)
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
