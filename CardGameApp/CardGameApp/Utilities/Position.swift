//
//  Position.swift
//  CardGameApp
//
//  Created by moon on 2018. 8. 2..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

// CardStack과 Foundation은 컨테이너안에서의 인덱스를 갖고있음.
enum Position {
    case cardDeck
    case wastePile
    case cardStack(Int)
    case foundation(Int)
}
