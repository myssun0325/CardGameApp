//
//  EmptyLayerView.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 28..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class EmptyLayerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setLayer()
    }
    
    private func setLayer() {
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
}
