//
//  CardDeck.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 19..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class CardDeck {
    private var cards: [Card] = []
    
    init(_ cards: [Card]) {
        self.cards = cards
    }
    
    init() {
        resetCards()
    }
    
    var topCard: Card? {
        return self.cards.last
    }
    
    // Fisher–Yates shuffle
    private func shuffleCards() {
        var shuffled = [Card]()
        for count in stride(from: UInt32(self.cards.count), to: 0, by: -1) {
            shuffled.append(self.cards.remove(at: Int(arc4random_uniform(count))))
        }
        self.cards = shuffled
    }
}

extension CardDeck: CardDeckProtocol {
    func resetCards() {
        var cards: [Card] = [Card]()
        for suit in Card.Suit.allCases {
            for number in Card.Number.allCases {
                cards.append(Card(suit: suit, number: number))
            }
        }
        self.cards = cards
        self.shuffleCards()
    }
    
    func removeTopCard() -> Card? {
        guard let topCard = self.cards.popLast() else { return nil }
        topCard.flip()
        return topCard
    }
    
    func removeTopCards(count: Int) -> [Card] {
        var removedCards = [Card]()
        for _ in 0..<count {
            if let removedCard = removeTopCard() {
                removedCards.append(removedCard)
            }
        }
        return removedCards
    }
}

extension CardDeck: WastePileProtocol {
    func addCard(_ card: Card) {
        self.cards.append(card)
    }
}
