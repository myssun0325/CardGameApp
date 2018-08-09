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
    
    func open() {
        isOpen = true
    }
    
    func close() {
        isOpen = false
    }
    
    init(suit: Suit, number: Number) {
        self.suit = suit
        self.number = number
    }
    
    var description: String {
        return self.suit.description + self.number.description
    }
    
    func isEqualNumber(_ number: Number) -> Bool {
        return self.number == number
    }
    
    func isEqualSuitCard(_ card: Card) -> Bool {
        return self.suit == card.suit
    }
    
    func isEqualNumberCard(_ card: Card) -> Bool {
        return self.number == card.number
    }
    
    func isNextCardInFoundationDeck(_ card: Card) -> Bool {
        return (card.number.rawValue == self.number.rawValue + 1) && (card.suit == self.suit)
    }
    
    func isNextCardInCardStack(_ card: Card) -> Bool {
        guard (self.number.rawValue - 1) == card.number.rawValue else { return false }
        switch self.suit {
        case .clubs, .spades:
            if card.suit == .clubs || card.suit == .spades { return false }
        default:
            if card.suit == .diamonds || card.suit == .hearts { return false }
        }
        return true
    }
}

extension Card: Comparable {
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.number < rhs.number
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return (lhs.number == rhs.number) && (lhs.suit == rhs.suit)
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
        
        case ace = 1, two = 2, three, four, five, six, seven, eight, nine, ten, jack, queen, king
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
        static var allCases: [Number] = [.ace, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king]
    }
}
