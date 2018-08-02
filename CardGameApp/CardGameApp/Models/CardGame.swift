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
        
        (1...CardGame.numberOfCardStacks).forEach {
            var removed: [Card] = [Card]()
            (0..<$0).forEach { _ in
                if let opened = cardDeck.openTopCard() {
                    removed.append(opened)
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
