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
    var foundationContainerViewModel: FoundationContainerViewModel!
    private var foundationDeckViews: [FoundationDeckView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setEmptyLayerViews(numberOfFoundation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setEmptyLayerViews(numberOfFoundation)
    }
    
    func makeFoundationDeckViews() {
        for (index, foundationDeckViewModel) in foundationContainerViewModel.enumerated() {
            let foundationDeckView = FoundationDeckView(viewModel: foundationDeckViewModel,
                                                        frame: CGRect(origin: CGPoint(x: (CGFloat(index) * CardSize.originXSpacing), y: 0),
                                                                      size: CGSize(width: CardSize.width, height: CardSize.height)))
            self.foundationDeckViews.append(foundationDeckView)
            self.addSubview(foundationDeckView)
        }
    }
    
    func resetFoundationDeckViews() {
        foundationDeckViews.forEach { $0.removeFromSuperview() }
        foundationDeckViews.removeAll()
    }
    
    subscript(index: Int) -> FoundationDeckView {
        return foundationDeckViews[index]
    }
}
