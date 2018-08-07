//
//  FoundationContainer.swift
//  CardGameApp
//
//  Created by moon on 2018. 8. 6..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class FoundationContainer: IteratorProtocol, Sequence {
    private var foundationDecks: [FoundationDeck] = []
    
    init() {
        (0..<4).forEach { _ in
            self.foundationDecks.append(FoundationDeck())
        }
    }
    
    func emptyAllFoundationDecks() {
        foundationDecks.forEach { $0.reset() }
    }
    
    func firstIndexOfEmptyFoundationDeck() -> Int {
        for (index, foundationDeck) in foundationDecks.enumerated() {
            if foundationDeck.isEmpty() { return index }
        }
        return 0
    }
    
    // 들어갈 수 있는 Foundation이 있는지 확인
    func canPushFoundationDecks(_ card: Card) -> Position? {
        for (index, foundationDeck) in foundationDecks.enumerated() {
            if foundationDeck.isNextCard(card) {
                return Position.foundation(index)
            }
        }
        return nil
    }

    // Iterator, Sequence
    private var index: Int = 0
    func next() -> FoundationDeck? {
        if index < self.foundationDecks.endIndex {
            defer { index = self.foundationDecks.index(after: index) }
            return self.foundationDecks[index]
        } else {
            self.index = 0
            return nil
        }
    }
    
    subscript(index: Int) -> FoundationDeck {
        return foundationDecks[index]
    }
}
