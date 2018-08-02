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
    private var cardGameViewModel: CardGameViewModel!
    private var frameInformation: FrameInformation!
    
    lazy var foundationContainerView = FoundationContainerView(frame: frameInformation.foundationContainerViewFrame)
    lazy var cardStackContainerView = CardStackContainerView(frame: frameInformation.cardStackContainerViewFrame)
    lazy var wastePileView = WastePileView(frame: frameInformation.wastePileViewFrame)
    lazy var cardDeckView = CardDeckView(frame: frameInformation.cardDeckViewFrame)
    
    func setupConatinerViews() {
        self.addSubview(foundationContainerView)
        self.addSubview(cardStackContainerView)
        self.addSubview(wastePileView)
        self.addSubview(cardDeckView)
    }
    
    func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.cardGameVMDidReset(_:)), name: .cardGameVMDidReset, object: cardGameViewModel)
    }
    
    @objc func cardGameVMDidReset(_ notification: Notification) {
        self.cardDeckView.makeCardViews()
    }
    
    convenience init(viewModel: CardGameViewModel, frame: CGRect) {
        self.init(frame: frame)
        frameInformation = FrameInformation(frame: frame)
        setupConatinerViews()
        cardGameViewModel = viewModel
        cardDeckView.cardDeckViewModel = viewModel.cardDeckViewModel
        setupNotificationObservers()
    }
    
    func resetGame() {
        self.cardGameViewModel.resetGame()
    }
}

extension CardGameView {
    struct FrameInformation {
        let foundationContainerViewFrame: CGRect
        let cardStackContainerViewFrame: CGRect
        let wastePileViewFrame: CGRect
        let cardDeckViewFrame: CGRect
        
        init(frame: CGRect) {
            let foundationConatinerViewOrigin = CGPoint(x: CardSize.spacing, y: 20)
            let foundationConatinerViewSize = CGSize(width: CardSize.originXSpacing * 4, height: CardSize.height)
            self.foundationContainerViewFrame = CGRect(origin: foundationConatinerViewOrigin, size: foundationConatinerViewSize)
            
            let cardStackContainerViewOrigin = CGPoint(x: CardSize.spacing, y: 100)
            let cardStackContainerViewSize = CGSize(width: CardSize.originXSpacing * 7, height: CardSize.height)
            self.cardStackContainerViewFrame = CGRect(origin: cardStackContainerViewOrigin, size: cardStackContainerViewSize)
            
            let wastePileViewOrigin = CGPoint(x: CardSize.originXSpacing * 5 + CardSize.spacing, y: 20)
            self.wastePileViewFrame = CGRect(origin: wastePileViewOrigin, size: CGSize(width: CardSize.width, height: CardSize.height))
            
            let cardDeckViewOrigin = CGPoint(x: CardSize.originXSpacing * 6 + CardSize.spacing, y: 20)
            self.cardDeckViewFrame = CGRect(origin: cardDeckViewOrigin, size: CGSize(width: CardSize.width, height: CardSize.height))
        }
    }
}
