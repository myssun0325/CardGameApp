//
//  CardStackView.swift
//  CardGameApp
//
//  Created by moon on 2018. 8. 2..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class CardStackView: UIView {
    var cardStackViewModel: CardStackViewModel!
    private var cardViews: [CardView] = []
    
    convenience init(viewModel: CardStackViewModel, frame: CGRect) {
        self.init(frame: frame)
        self.cardStackViewModel = viewModel
        self.isUserInteractionEnabled = true
    }
    
    func makeCardViews() {
        for cardViewModel in cardStackViewModel {
            var originY: CGFloat = 0
            if let topCard = self.subviews.last {
                originY = topCard.frame.origin.y + CardSize.height * 0.2
            }
            let cardOrigin = CGPoint(x: 0, y: originY)
            let cardView = CardView(viewModel: cardViewModel, frame:CGRect(origin: cardOrigin, size: CGSize(width: CardSize.width, height: CardSize.height)))
            self.cardViews.append(cardView)
            self.addSubview(cardView)
        }
    }
}
