//
//  CardStackManager.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 23..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class CardStackManager {
    private var cardStacks: [CardStack] = []
    
    func resetCardStacks() {
        cardStacks.removeAll()
    }
    
    func addCardStack(_ cards: [Card]) {
        cardStacks.append(CardStack(cards))
    }
    
    func imageNameOfCardStack(index: Int) -> String? {
        return cardStacks[index].topCard?.frontImageName
    }
    
    func cardsStack(at index: Int) -> CardStack {
        return cardStacks[index]
    }
}
