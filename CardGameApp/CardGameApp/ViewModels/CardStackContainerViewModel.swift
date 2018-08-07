//
//  CardStackContainerViewModel.swift
//  CardGameApp
//
//  Created by moon on 2018. 8. 2..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class CardStackContainerViewModel: IteratorProtocol, Sequence {
    private let cardStackContainer: CardStackContainer
    private var cardStackViewModels: [CardStackViewModel] = []
    
    init(cardStackContainer: CardStackContainer) {
        self.cardStackContainer = cardStackContainer
    }
    
    func initCardStackViewModels() {
        self.cardStackViewModels.removeAll()
        for cardStack in cardStackContainer {
            self.cardStackViewModels.append(CardStackViewModel(cardStack: cardStack))
        }
    }
    
    func indexOfCardStack(_ cardViewModel: CardViewModel) -> Int? {
        for (index, cardStackViewModel) in cardStackViewModels.enumerated() {
            if cardStackViewModel.contains(cardViewModel) {
                return index
            }
        }
        return nil
    }
    
    // Iterator, Sequence
    private var index: Int = 0
    func next() -> CardStackViewModel? {
        if index < self.cardStackViewModels.endIndex {
            defer { index = self.cardStackViewModels.index(after: index) }
            return self.cardStackViewModels[index]
        } else {
            self.index = 0
            return nil
        }
    }
}
