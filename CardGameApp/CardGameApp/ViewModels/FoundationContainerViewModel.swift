//
//  FoundationContainerViewModel.swift
//  CardGameApp
//
//  Created by moon on 2018. 8. 7..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class FoundationContainerViewModel: IteratorProtocol, Sequence {
    private let foundationContainer: FoundationContainer
    private var foundationDeckViewModels: [FoundationDeckViewModel] = []
    
    init(foundationContainer: FoundationContainer) {
        self.foundationContainer = foundationContainer
    }
    
    func initFoundationDeckViewModels() {
        self.foundationDeckViewModels.removeAll()
        for foundationDeck in foundationContainer {
            self.foundationDeckViewModels.append(FoundationDeckViewModel(foundationDeck: foundationDeck))
        }
    }
    
    func push(cardViewModel: CardViewModel, at index: Int) {
        self.foundationDeckViewModels[index].push(cardViewModel: cardViewModel)
    }
    
    // Iterator, Sequence
    private var index: Int = 0
    func next() -> FoundationDeckViewModel? {
        if index < self.foundationDeckViewModels.endIndex {
            defer { index = self.foundationDeckViewModels.index(after: index) }
            return self.foundationDeckViewModels[index]
        } else {
            self.index = 0
            return nil
        }
    }
}
