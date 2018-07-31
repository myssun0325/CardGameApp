//
//  CardDeckView.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 19..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class CardDeckView: UIImageView {
    var cardDeckViewModel: CardDeckViewModel!
    var cardViews: [CardView] = [CardView]()
    
    private func defaultSetup() {
        image = UIImage(named: ImageName.deckRefresh)
        self.isUserInteractionEnabled = true
    }
    
    convenience init(viewModel: CardDeckViewModel, frame: CGRect) {
        self.init(frame: frame)
        self.cardDeckViewModel = viewModel
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultSetup()
    }
    
    func makeCardViews() {
        for cardViewModel in cardDeckViewModel {
            let cardView = CardView(viewModel: cardViewModel, frame: self.bounds)
            self.cardViews.append(cardView)
            self.addSubview(cardView)
        }
    }
}
