//
//  NotificationExtension.swift
//  CardGameApp
//
//  Created by moon on 2018. 8. 2..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let cardGameDidReset = Notification.Name("cardGameDidReset")
    static let cardGameVMDidReset = Notification.Name("cardGameVMDidReset")
    static let cardDeckOpened = Notification.Name("cardDeckOpened")
    static let wastePileRecycled = Notification.Name("wastePileRecycled")
//    static let cardDeckOpend = Notification.Name("cardDeckOpend")
}
