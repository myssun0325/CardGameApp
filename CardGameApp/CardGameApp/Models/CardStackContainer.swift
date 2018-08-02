//
//  CardStackManager.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 23..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class CardStackContainer: IteratorProtocol, Sequence {
    private var cardStacks: [CardStack] = []
    
    func emptyAllCardStacks() {
        cardStacks.removeAll()
    }
    
    func addCardStack(_ cards: [Card]) {
        cardStacks.append(CardStack(cards))
    }
    
    func cardStack(at index: Int) -> CardStack {
        return cardStacks[index]
    }
    
    func push(card: Card, index: Int) {
        self.cardStacks[index].add(card: card)
    }
    
    // Iterator, Sequence
    private var index: Int = 0
    func next() -> CardStack? {
        if index < self.cardStacks.endIndex {
            defer { index = self.cardStacks.index(after: index) }
            return self.cardStacks[index]
        } else {
            self.index = 0
            return nil
        }
    }
}
