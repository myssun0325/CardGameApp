//
//  CardGame.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 22..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class CardGame {
    private var cardDeck: CardDeck = CardDeck()
    private var wastePile: [Card] = []
    
    func gameReset() {
        cardDeck.reset()
        wastePile.removeAll()
    }
    
    func openCardDeck() {
        if let topCard = cardDeck.popTopCard() {
            wastePile.append(topCard)
        } else {
            cardDeck.push(cards: wastePile)
            wastePile.removeAll()
        }
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
}
