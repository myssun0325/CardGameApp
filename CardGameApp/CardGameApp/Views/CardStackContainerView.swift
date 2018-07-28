//
//  CardStackContainerView.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 28..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class CardStackContainerView: UIView, EmptyViewSettable {
    
    private var numberOfCardStack = 7
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setEmptyLayerViews(numberOfCardStack)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setEmptyLayerViews(numberOfCardStack)
    }
}
