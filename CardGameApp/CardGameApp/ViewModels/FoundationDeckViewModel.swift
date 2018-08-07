//
//  FoundationDeckViewModel.swift
//  CardGameApp
//
//  Created by moon on 2018. 8. 7..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class FoundationDeckViewModel: IteratorProtocol, Sequence {
    private let foundationDeck: FoundationDeck
    private var cardViewModels: [CardViewModel] = []
    
    init(foundationDeck: FoundationDeck) {
        self.foundationDeck = foundationDeck
    }
    
    func initCardViewModel() {
        cardViewModels.removeAll()
        for card in foundationDeck {
            cardViewModels.append(CardViewModel(card: card))
        }
    }
    
    func push(cardViewModel: CardViewModel) {
        self.cardViewModels.append(cardViewModel)
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
