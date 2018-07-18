//
//  Card.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 19..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class Card {
    private let suit: Suit
    private let number: Number
    
    init(suit: Suit, number: Number) {
        self.suit = suit
        self.number = number
    }
}

extension Card {
    enum Suit: CustomStringConvertible, CaseIterable {
        case clubs, diamonds, hearts, spades
        var description: String {
            switch self {
            case .clubs:    return "c"
            case .diamonds: return "d"
            case .hearts:   return "h"
            case .spades:   return "s"
            }
        }
    }
    
    enum Number: Int, CustomStringConvertible, CaseIterable {
        case two = 2, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace
        var description: String {
            switch self {
            case .jack: return "J"
            case .queen: return "Q"
            case .king: return "K"
            case .ace: return "A"
            default:
                return String(self.rawValue)
            }
        }
    }
    
}

extension Card: CustomStringConvertible {
    var description: String {
        return self.suit.description + self.number.description
    }
}
