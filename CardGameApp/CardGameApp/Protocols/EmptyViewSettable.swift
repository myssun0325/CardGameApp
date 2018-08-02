//
//  EmptyViewSettable.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 28..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

protocol EmptyViewSettable: class {
    func setEmptyLayerViews(_ numberOfView: Int)
}

extension EmptyViewSettable where Self: UIView {
    func setEmptyLayerViews(_ numberOfView: Int) {
        for index in 0..<numberOfView {
            let emptyLayerView = EmptyLayerView(frame: CGRect(x: CGFloat(index) * CardSize.originXSpacing,
                                                              y: 0,
                                                              width: CardSize.width,
                                                              height: CardSize.height))
            self.addSubview(emptyLayerView)
        }
    }
}
