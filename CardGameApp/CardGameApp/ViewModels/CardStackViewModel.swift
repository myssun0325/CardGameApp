//
//  CardStackViewModel.swift
//  CardGameApp
//
//  Created by moon on 2018. 8. 2..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class CardStackViewModel: IteratorProtocol, Sequence {
    private let cardStack: CardStack
    private var cardViewModels: [CardViewModel] = []
    
    init(cardStack: CardStack) {
        self.cardStack = cardStack
    }
    
    func initCardViewModels() {
        self.cardViewModels.removeAll()
        for card in cardStack {
            cardViewModels.append(CardViewModel(card: card))
        }
    }
    
    var topCardViewModel: CardViewModel? {
        return cardViewModels.last
    }
    
    func popCardViewModel() -> CardViewModel? {
        return cardViewModels.popLast()
    }
    
    func push(cardViewModel: CardViewModel) {
        cardViewModels.append(cardViewModel)
    }
    
    func contain(_ cardViewModel: CardViewModel) -> Bool {
        for viewModel in cardViewModels {
            if cardViewModel == viewModel {
                return true
            }
        }
        return false
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
