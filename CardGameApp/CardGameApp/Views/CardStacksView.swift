//
//  CardStacksView.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 19..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class CardStacksView: UIView {
    
    private let numberOfStack = 7
    private let distanceOfStacksX: CGFloat = CardSize.width + CardSize.spacing
    private var stack: [UIImageView] = []
    
    lazy var totalWidth: CGFloat = distanceOfStacksX * CGFloat(numberOfStack)
    
    private func defaultSetup() {
        for count in 0..<numberOfStack {
            let cardStack = UIImageView(frame: CGRect(x: CGFloat(count) * distanceOfStacksX,
                                                      y: self.frame.origin.x,
                                                      width: CardSize.width,
                                                      height: CardSize.height))
            self.stack.append(cardStack)
            cardStack.setEmptyLayer()
            self.addSubview(cardStack)
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
    
    func setImagesOfAllStack(_ images: [UIImage]) {
        for index in images.indices {
            stack[index].image = images[index]
        }
    }
}
