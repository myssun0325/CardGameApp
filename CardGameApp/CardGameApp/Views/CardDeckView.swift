//
//  CardDeckView.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 19..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class CardDeckView: UIImageView, IteratorProtocol, Sequence {
    var cardDeckViewModel: CardDeckViewModel!
    private var cardViews: [CardView] = []
    
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
    
    func popTopCardView() -> CardView? {
        return cardViews.popLast()
    }
    
    func push(cardView: CardView) {
        self.cardViews.append(cardView)
        self.addSubview(cardView)
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
