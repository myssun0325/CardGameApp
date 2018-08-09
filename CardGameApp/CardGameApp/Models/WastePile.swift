//
//  WastePile.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 30..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class WastePile {
    private var cards: [Card] = []
    
    func isAceOnTop() -> Bool {
        guard let topCard = self.cards.last else { return false }
        return topCard.isEqualNumber(.ace)
    }
    
    func emptyAllCards() {
        cards.removeAll()
    }
    
    func push(card: Card) {
        self.cards.append(card)
    }
    
    func popTopCard() -> Card? {
        return cards.popLast()
    }
    
    func recycle() -> [Card] {
        let reversed: [Card] = cards.reversed()
        reversed.forEach { $0.close() }
        cards.removeAll()
        return reversed
    }
}
