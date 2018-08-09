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
        cardStackContainer.forEach { $0.topCard?.open() }
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
            removed.open()
            wastePile.push(card: removed)
            NotificationCenter.default.post(name: .cardDeckDidOpen, object: self)
        } else {
            wastePile.recycle().forEach { cardDeck.push(card: $0) }
            NotificationCenter.default.post(name: .wastePileDidRecycle, object: self)
        }
    }
    
    private func checkIfAceCard(_ card: Card) -> Position? {
        if card.isEqualNumber(.ace) {
            let foundationDeckIndex = foundationContainer.firstIndexOfEmptyFoundationDeck()
            return Position.foundation(foundationDeckIndex)
        }
        return nil
    }
    
    private func checkAceOrKing(_ card: Card) -> Position? {
        if let position = checkIfAceCard(card) {
            return position
        }
        if let position = cardStackContainer.checkIfKingCard(card) {
            return position
        }
        return nil
    }
    
    private func checkFoundationDeckOrCardStack(_ card: Card) -> Position? {
        if let position = self.foundationContainer.canPushFoundationDecks(card) {
            return position
        }
        if let position = self.cardStackContainer.canPushCardStack(card) {
            return position
        }
        return nil
    }
    
    func positionToMove(card: Card, from: Position) -> Position? {
        if let toPosition = checkAceOrKing(card) { return toPosition }
        switch from {
        case .wastePile:
            break
        case .cardStack(let index):
            // Stack에서 온거라면 Stack의 마지막 카드인지를 확인
            guard let topCard = self.cardStackContainer[index].topCard else { return nil }
            guard topCard == card else { return nil }
        default:
            return nil
        }
        if let toPosition = checkFoundationDeckOrCardStack(card) { return toPosition }
        return nil
    }
    
    private func popCard(from: Position) -> Card? {
        switch from {
        case .wastePile:
            return wastePile.popTopCard()
        case .cardStack(let index):
            return cardStackContainer[index].popTopCard()
        default:
            return nil
        }
    }
    
    private func push(_ card: Card, _ toPosition: Position) {
        switch toPosition {
        case .foundation(let index):
            foundationContainer[index].push(card: card)
        case .cardStack(let index):
            cardStackContainer[index].push(card: card)
        default:
            break
        }
    }
    
    func moveCard(from fromPosition: Position, to toPosition: Position) {
        guard let card = popCard(from: fromPosition) else { return }
        push(card, toPosition)
        let moveInfo = ["from": fromPosition, "to": toPosition]
        NotificationCenter.default.post(name: .cardDidMoved, object: self, userInfo: moveInfo)
    }
}
