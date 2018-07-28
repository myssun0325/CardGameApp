//
//  FoundationContainerView.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 28..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class FoundationContainerView: UIView, EmptyViewSettable {

    private var numberOfFoundation = 4
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setEmptyLayerViews(numberOfFoundation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setEmptyLayerViews(numberOfFoundation)
    }
}
