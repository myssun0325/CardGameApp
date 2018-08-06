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
    private(set) var foundationContainer: FoundationContainer = FoundationContainer()
    
    fileprivate func setupDefaultCardStacks() {
        (1...CardGame.numberOfCardStacks).forEach {
            cardStackContainer.addCardStack(openCardsOfCardDeck($0))
        }
        cardStackContainer.forEach { $0.topCard?.flip() }
    }
    
    fileprivate func openCardsOfCardDeck(_ numberOfCards: Int) -> [Card] {
        return (0..<numberOfCards).map({ _ in cardDeck.openTopCard() }).compactMap { $0 }
    }
    
    func resetGame() {
        cardDeck.fillDefaultShuffledCards()
        wastePile.emptyAllCards()
        cardStackContainer.emptyAllCardStacks()
        foundationContainer.emptyAllFoundationDecks()
        setupDefaultCardStacks()
        NotificationCenter.default.post(name: .cardGameDidReset, object: self)
    }
    
    func openCardDeck() {
        if let removed: Card = cardDeck.openTopCard() {
            removed.flip()
            wastePile.push(card: removed)
            NotificationCenter.default.post(name: .cardDeckDidOpen, object: self)
        } else {
            wastePile.recycle().forEach { cardDeck.push(card: $0) }
            NotificationCenter.default.post(name: .wastePileDidRecycle, object: self)
        }
    }
}
