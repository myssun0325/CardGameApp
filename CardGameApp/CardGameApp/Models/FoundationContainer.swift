//
//  FoundationContainer.swift
//  CardGameApp
//
//  Created by moon on 2018. 8. 6..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class FoundationContainer: IteratorProtocol, Sequence {
    private var foundationDecks: [FoundationDeck] = []
    
    func emptyAllFoundationDecks() {
        foundationDecks.removeAll()
    }
    
    // Iterator, Sequence
    private var index: Int = 0
    func next() -> FoundationDeck? {
        if index < self.foundationDecks.endIndex {
            defer { index = self.foundationDecks.index(after: index) }
            return self.foundationDecks[index]
        } else {
            self.index = 0
            return nil
        }
    }
}
