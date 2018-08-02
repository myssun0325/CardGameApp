//
//  WastePileView.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 28..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class WastePileView: UIView, EmptyViewSettable {
    var wastePileViewModel: WastePileViewModel!
    private var cardViews: [CardView] = []
    
    convenience init(viewModel: WastePileViewModel, frame: CGRect) {
        self.init(frame: frame)
        self.wastePileViewModel = viewModel
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setEmptyLayerViews(1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setEmptyLayerViews(1)
    }
    
    func push(cardView: CardView) {
        self.cardViews.append(cardView)
        self.addSubview(cardView)
    }
    
    func popTopCardView() -> CardView? {
        return cardViews.popLast()
    }
}
