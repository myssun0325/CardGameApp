//
//  WastePileViewModel.swift
//  CardGameApp
//
//  Created by moon on 2018. 8. 2..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class WastePileViewModel: IteratorProtocol, Sequence {
    private let wastePile: WastePile
    private var cardViewModels: [CardViewModel] = []
    
    init(wastePile: WastePile) {
        self.wastePile = wastePile
    }
    
    func initCardViewModels() {
        self.cardViewModels.removeAll()
    }
    
    func push(cardViewModel: CardViewModel) {
        cardViewModels.append(cardViewModel)
    }
    
    func removeAllCardViewModels() -> [CardViewModel] {
        let removed = cardViewModels
        cardViewModels.removeAll()
        return removed
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
