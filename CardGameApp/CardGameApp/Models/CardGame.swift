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
    private var wastePile: WastePile = WastePile()
    private var cardStackContainer: CardStackContainer = CardStackContainer()
    
    func resetGame() {
        cardDeck.fillDefaultShuffledCards()
        wastePile.emptyAllCards()
        cardStackContainer.emptyAllCardStacks()
        NotificationCenter.default.post(name: .cardGameDidReset, object: self)
    }
}

enum Position {
    case cardDeck
    case wastePile
    case cardStack(Int)
    case foundation(Int)
}
