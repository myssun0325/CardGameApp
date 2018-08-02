//
//  Position.swift
//  CardGameApp
//
//  Created by moon on 2018. 8. 2..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

enum Position {
    case cardDeck
    case wastePile
    case cardStack(index: Int)
    case foundation(index: Int)
}
