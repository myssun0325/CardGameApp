//
//  CardDeckView.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 19..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class CardDeckView: UIImageView, EmptyViewSettable {
    
    private func defaultSetup() {
        image = UIImage(named: ImageName.deckRefresh)
        self.isUserInteractionEnabled = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultSetup()
        self.setEmptyLayerViews(1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultSetup()
        self.setEmptyLayerViews(1)
    }
}
