//
//  WastePileView.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 28..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class WastePileView: UIView, EmptyViewSettable, IteratorProtocol, Sequence {
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
    
    func resetCardViews() {
        self.cardViews.forEach { $0.removeFromSuperview() }
        self.cardViews.removeAll()
    }
    
    // Iterator, Sequence
    private var index: Int = 0
    func next() -> CardView? {
        if index < self.cardViews.endIndex {
            defer { index = self.cardViews.index(after: index) }
            return self.cardViews[index]
        } else {
            self.index = 0
            return nil
        }
    }
}
