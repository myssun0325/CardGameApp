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
    
    private var cardDeck: CardDeck = CardDeck()
    private var wastePile: [Card] = []
    private var cardStackManager: CardStackManager = CardStackManager()
    
    func gameReset() {
        cardDeck.reset()
        wastePile.removeAll()
        cardStackManager.resetCardStacks()
        for count in 1...CardGame.numberOfCardStacks {
            cardStackManager.addCardStack(cardDeck.popCards(count: count))
        }
        NotificationCenter.default.post(name: .gameReset, object: self)
    }
    
    func openCardDeck() {
        if let topCard = cardDeck.popTopCard() {
            wastePile.append(topCard)
        } else {
            cardDeck.push(cards: wastePile.reversed())
            wastePile.removeAll()
        }
        NotificationCenter.default.post(name: .cardDeckIsOpend, object: self)
    }
    
    func topCardImageNameOfCardDeck() -> String {
        guard let topCard = cardDeck.topCard else {
            return ImageName.deckRefresh
        }
        return topCard.backImageName
    }
    
    func topCardImageNameOfWastePile() -> String? {
        guard let topCard = wastePile.last else {
            return nil
        }
        return topCard.frontImageName
    }
    
    func cardStack(at index: Int) -> CardStack {
        return self.cardStackManager.cardsStack(at: index)
    }
}
