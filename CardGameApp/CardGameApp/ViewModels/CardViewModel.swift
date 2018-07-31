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
    let card: Card
    
    var imageName: String {
        return card.cardImageName
    }
    
    init(card: Card) {
        self.card = card
    }
}
