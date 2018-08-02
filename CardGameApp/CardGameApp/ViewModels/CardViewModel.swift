//
//  CardViewModel.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 26..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class CardViewModel {
    // Model
    private let card: Card
    private(set) var imageName: String
    
    var isOpen: Bool {
        return card.isOpen
    }
    
    init(card: Card) {
        self.card = card
        self.imageName = "\(card)"
    }
}
