//
//  CardStackContainerView.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 28..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class CardStackContainerView: UIStackView, EmptyViewSettable, IteratorProtocol, Sequence {
    private let numberOfCardStack = 7
    var cardStackContainerViewModel: CardStackContainerViewModel!
    private var cardStackViews: [CardStackView] = []
    
    private func setupStackViewAttributes() {
        axis = .horizontal
        distribution = .equalSpacing
        alignment = .top
        spacing = 5
    }
    
    convenience init(viewModel: CardStackContainerViewModel, frame: CGRect) {
        self.init(frame: frame)
        self.cardStackContainerViewModel = viewModel
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setEmptyLayerViews(numberOfCardStack)
        setupStackViewAttributes()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setEmptyLayerViews(numberOfCardStack)
        setupStackViewAttributes()
    }
    
    func makeCardStackViews() {
        for cardStackViewModel in cardStackContainerViewModel {
            let cardStackView = CardStackView(viewModel: cardStackViewModel, frame: .zero)
            cardStackView.widthAnchor.constraint(equalToConstant: CardSize.width).isActive = true
            self.cardStackViews.append(cardStackView)
            self.addArrangedSubview(cardStackView)
        }
    }
    
    func makeCardViews() {
        cardStackViews.forEach { $0.makeCardViews() }
    }
    
    func resetCardStackViews() {
        self.cardStackViews.forEach { $0.removeFromSuperview() }
        self.cardStackViews.removeAll()
    }
    
    func topCardView(at index: Int) -> CardView? {
        return self.cardStackViews[index].topCardView
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
    
    subscript(index: Int) -> CardStackView {
        return self.cardStackViews[index]
    }
}
