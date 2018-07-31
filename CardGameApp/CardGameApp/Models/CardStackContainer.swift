//
//  CardStackManager.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 23..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class CardStackContainer {
    private var cardStacks: [CardStack] = []
    
    func emptyAllCardStacks() {
        cardStacks.removeAll()
    }
    
    func addCardStack(_ cards: [Card]) {
        cardStacks.append(CardStack(cards))
    }
    
    func cardStack(at index: Int) -> CardStack {
        return cardStacks[index]
    }
}
