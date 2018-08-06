//
//  Card.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 19..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class Card: CustomStringConvertible {
    
    private let suit: Suit
    private let number: Number
    private(set) var isOpen: Bool = false
    
    func flip() {
        isOpen = !isOpen
    }
    
    init(suit: Suit, number: Number) {
        self.suit = suit
        self.number = number
    }
    
    var description: String {
        return self.suit.description + self.number.description
    }
}

extension Card: Comparable {
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.number < rhs.number
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.number == rhs.number && lhs.number == rhs.number
    }
}

extension Card {
    enum Suit: CustomStringConvertible {
        case clubs, diamonds, hearts, spades
        var description: String {
            switch self {
            case .clubs:    return "c"
            case .diamonds: return "d"
            case .hearts:   return "h"
            case .spades:   return "s"
            }
        }
        static var allCases: [Suit] = [.clubs, .diamonds, .hearts, .spades]
    }
    
    enum Number: Int, CustomStringConvertible, Comparable {
        static func < (lhs: Card.Number, rhs: Card.Number) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
        
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
        static var allCases: [Number] = [.two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king, .ace]
    }
}
