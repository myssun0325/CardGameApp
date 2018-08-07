//
//  CardGameView.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 27..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class CardGameView: UIView {
    // ViewModel
    private var cardGameViewModel: CardGameViewModelProtocol!
    private let topSpacing: CGFloat = 20
    private let cardStackContainerTopSpacing: CGFloat = 100
    private let numberOfFoundation: CGFloat = 4
    private let numberOfCardStacks: CGFloat = 7
    
    lazy var foundationContainerView = FoundationContainerView(frame: CGRect(origin: CGPoint(x: CardSize.spacing, y: topSpacing), size: CGSize(width: CardSize.originXSpacing * numberOfFoundation, height: CardSize.height)))
    lazy var cardStackContainerView = CardStackContainerView(frame: .zero)
    lazy var wastePileView = WastePileView(frame: CGRect(origin: CGPoint(x: CardSize.originXSpacing * 5 + CardSize.spacing, y: topSpacing), size: CGSize(width: CardSize.width, height: CardSize.height)))
    lazy var cardDeckView = CardDeckView(frame: CGRect(origin: CGPoint(x: CardSize.originXSpacing * 6 + CardSize.spacing, y: topSpacing), size: CGSize(width: CardSize.width, height: CardSize.height)))
    
    private func setupConatinerViews() {
        self.addSubview(foundationContainerView)
        self.addSubview(cardStackContainerView)
        self.addSubview(wastePileView)
        self.addSubview(cardDeckView)
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.cardGameVMDidReset(_:)), name: .cardGameVMDidReset, object: cardGameViewModel)
        NotificationCenter.default.addObserver(self, selector: #selector(self.cardDeckVMDidOpen(_:)), name: .cardDeckVMDidOpen, object: cardGameViewModel)
        NotificationCenter.default.addObserver(self, selector: #selector(self.wastePileVMDidRecycle(_:)), name: .wastePileVMDidRecycle, object: cardGameViewModel)
        NotificationCenter.default.addObserver(self, selector: #selector(self.cardVMDidMoved(_:)), name: .cardVMDidMoved, object: cardGameViewModel)
    }
    
    private func setupCardStackConstraints() {
        cardStackContainerView.translatesAutoresizingMaskIntoConstraints = false
        cardStackContainerView.topAnchor.constraint(equalTo: foundationContainerView.bottomAnchor, constant: topSpacing).isActive = true
        cardStackContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CardSize.spacing).isActive = true
    }
    
    @objc func cardGameVMDidReset(_ notification: Notification) {
        cardDeckView.resetCardViews()
        wastePileView.resetCardViews()
        cardStackContainerView.resetCardStackViews()
        cardDeckView.makeCardViews()
        cardStackContainerView.makeCardStackViews()
        cardStackContainerView.makeCardViews()
        foundationContainerView.makeFoundationDeckViews()
    }
    
    @objc func cardDeckVMDidOpen(_ notification: Notification) {
        guard let popped: CardView = self.cardDeckView.popTopCardView() else { return }
        popped.isHighlighted = popped.cardViewModel.isOpen
        wastePileView.push(cardView: popped)
    }
    
    @objc func wastePileVMDidRecycle(_ notification: Notification) {
        while let popped: CardView = self.wastePileView.popTopCardView() {
            popped.isHighlighted = popped.cardViewModel.isOpen
            cardDeckView.push(cardView: popped)
        }
    }
    
    @objc func cardVMDidMoved(_ notification: Notification) {
        guard let fromPosition = notification.userInfo?["from"] as? Position else { return }
        guard let toPosition = notification.userInfo?["to"] as? Position else { return }
        moveCardView(from: fromPosition, to: toPosition)
    }
    
    convenience init(viewModel: CardGameViewModelProtocol, frame: CGRect) {
        self.init(frame: frame)
        setupConatinerViews()
        setupCardStackConstraints()
        cardGameViewModel = viewModel
        cardDeckView.cardDeckViewModel = viewModel.cardDeckViewModel
        cardStackContainerView.cardStackContainerViewModel = viewModel.cardStackContainerViewModel
        wastePileView.wastePileViewModel = viewModel.wastePileViewModel
        foundationContainerView.foundationContainerViewModel = viewModel.foundationContainerViewModel
        setupNotificationObservers()
    }
    
    func resetGame() {
        self.cardGameViewModel.resetGame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: self) else { return }
        if self.cardDeckView.frame.contains(touchPoint) {
            cardGameViewModel.openCardDeck()
        }
    }
    
    func moveCardView(from fromPosition: Position, to toPosition: Position) {
        // 구현 준비 중
    }
}
