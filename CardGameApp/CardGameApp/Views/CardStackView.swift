//
//  CardStackView.swift
//  CardGameApp
//
//  Created by moon on 2018. 8. 2..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class CardStackView: UIStackView {
    var cardStackViewModel: CardStackViewModel!
    private var cardViews: [CardView] = []
    
    private func setupStackViewAttributes() {
        axis = .vertical
        distribution = .fillEqually
        alignment = .center
        spacing = -50
    }
    
    convenience init(viewModel: CardStackViewModel, frame: CGRect) {
        self.init(frame: frame)
        setupStackViewAttributes()
        self.cardStackViewModel = viewModel
        self.isUserInteractionEnabled = true
    }
    
    func makeCardViews() {
        for cardViewModel in cardStackViewModel {
            let cardView = CardView(viewModel: cardViewModel, frame: .zero)
            self.cardViews.append(cardView)
            self.addArrangedSubview(cardView)
        }
    }
    
    var topCardView: CardView? {
        return cardViews.last
    }
    
    func popTopCardView() -> CardView? {
        guard let topCard = cardViews.popLast() else {
            return nil
        }
        cardViews.last?.isHighlighted = cardViews.last?.cardViewModel.isOpen ?? false
        return topCard
    }
    
    func push(cardView: CardView) {
        self.cardViews.append(cardView)
        self.addArrangedSubview(cardView)
    }
}
