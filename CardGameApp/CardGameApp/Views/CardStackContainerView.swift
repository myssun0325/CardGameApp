//
//  CardStackContainerView.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 28..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class CardStackContainerView: UIView, EmptyViewSettable, IteratorProtocol, Sequence {
    private let numberOfCardStack = 7
    var cardStackContainerViewModel: CardStackContainerViewModel!
    private var cardStackViews: [CardStackView] = []
    
    convenience init(viewModel: CardStackContainerViewModel, frame: CGRect) {
        self.init(frame: frame)
        self.cardStackContainerViewModel = viewModel
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setEmptyLayerViews(numberOfCardStack)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setEmptyLayerViews(numberOfCardStack)
    }
    
    func makeCardStackViews() {
        self.cardStackViews.removeAll()
        for (index, cardStackViewModel) in cardStackContainerViewModel.enumerated() {
            let cardStackView = CardStackView(viewModel: cardStackViewModel, frame: CGRect(origin: CGPoint(x: CGFloat(index) * (CardSize.originXSpacing), y: 0), size: CGSize(width: CardSize.width, height: CardSize.height)))
            self.cardStackViews.append(cardStackView)
            self.addSubview(cardStackView)
        }
    }
    
    // Iterator, Sequence
    private var index: Int = 0
    func next() -> CardStackView? {
        if index < self.cardStackViews.endIndex {
            defer { index = self.cardStackViews.index(after: index) }
            return self.cardStackViews[index]
        } else {
            self.index = 0
            return nil
        }
    }
}
