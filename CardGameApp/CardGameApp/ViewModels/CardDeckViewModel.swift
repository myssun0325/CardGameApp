//
//  CardDeckViewModel.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 26..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class CardDeckViewModel: IteratorProtocol, Sequence {
    private let cardDeck: CardDeck
    private let refreshImageName: String = ImageName.deckRefresh
    private var cardViewModels: [CardViewModel] = []
    
    init(cardDeck: CardDeck) {
        self.cardDeck = cardDeck
    }
    
    func initCardViewModels() {
        for card in cardDeck {
            cardViewModels.append(CardViewModel(card: card))
        }
    }
    
    // Iterator, Sequence
    private var index: Int = 0
    func next() -> CardViewModel? {
        if index < self.cardViewModels.endIndex {
            defer { index = self.cardViewModels.index(after: index) }
            return self.cardViewModels[index]
        } else {
            self.index = 0
            return nil
        }
    }
}
