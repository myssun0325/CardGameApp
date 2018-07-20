//
//  CardStack.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 20..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class CardStack {
    private var cards: [Card] = [] {
        didSet {
            oldValue.last?.flip() // 이전 마지막 카드 다시 뒤집기
        }
    }
    
    func reset() {
        self.cards.removeAll()
    }
    
    func add(card: Card) {
        self.cards.append(card)
    }
}
