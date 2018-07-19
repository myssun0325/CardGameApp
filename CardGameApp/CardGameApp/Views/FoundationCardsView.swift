//
//  FoundationCardView.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 19..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class FoundationCardsView: UIView {
    
    private let numberOfFoundation = 4
    private let distanceOfconatinersX: CGFloat = CardSize.width + CardSize.spacing
    private var foundationContainerView: [UIView] = []
    var totalWidth: CGFloat {
        return distanceOfconatinersX * CGFloat(numberOfFoundation)
    }
    
    private func defaultSetup() {
        for count in 0..<numberOfFoundation {
            let foundation = UIView(frame: CGRect(x: CGFloat(count) * distanceOfconatinersX,
                               y: self.frame.origin.y,
                               width: CardSize.width,
                               height: CardSize.height))
            self.foundationContainerView.append(foundation)
            foundation.setEmptyLayer()
            self.addSubview(foundation)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultSetup()
    }
}
