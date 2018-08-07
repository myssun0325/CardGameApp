//
//  NotificationExtension.swift
//  CardGameApp
//
//  Created by moon on 2018. 8. 2..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

extension Notification.Name {
    // Model
    static let cardGameDidReset = Notification.Name("cardGameDidReset")
    static let cardDeckDidOpen = Notification.Name("cardDeckDidOpen")
    static let wastePileDidRecycle = Notification.Name("wastePileDidRecycle")
    static let cardDidPushedFoundationDeck = Notification.Name("cardDidPushedFoundationDeck")
    
    // ViewModel
    static let cardGameVMDidReset = Notification.Name("cardGameVMDidReset")
    static let cardDeckVMDidOpen = Notification.Name("cardDeckVMDidOpen")
    static let wastePileVMDidRecycle = Notification.Name("wastePileVMDidRecycle")
    static let cardDidDoubleTapped = Notification.Name("cardDidDoubleTapped")
}
