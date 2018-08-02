//
//  CardGame.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 22..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class CardGame {
    static let numberOfCardStacks = 7
    
    private(set) var cardDeck: CardDeck = CardDeck()
    private(set) var wastePile: WastePile = WastePile()
    private(set) var cardStackContainer: CardStackContainer = CardStackContainer()
    
    func resetGame() {
        cardDeck.fillDefaultShuffledCards()
        wastePile.emptyAllCards()
        cardStackContainer.emptyAllCardStacks()
        
        for cardStackIndex in 1...CardGame.numberOfCardStacks {
            var removed: [Card] = [Card]()
            for _ in 0..<cardStackIndex {
                if let popped = cardDeck.popTopCard() {
                    removed.append(popped)
                }
            }
            cardStackContainer.addCardStack(removed)
        }
        cardStackContainer.forEach { $0.topCard?.flip() }
        NotificationCenter.default.post(name: .cardGameDidReset, object: self)
    }
    
    func openCardDeck() {
        if let removed: Card = cardDeck.openTopCard() {
            removed.flip()
            wastePile.push(card: removed)
            NotificationCenter.default.post(name: .cardDeckOpened, object: self)
        } else {
            wastePile.recycle().forEach { cardDeck.push(card: $0) }
            NotificationCenter.default.post(name: .wastePileRecycled, object: self)
        }
    }
}
