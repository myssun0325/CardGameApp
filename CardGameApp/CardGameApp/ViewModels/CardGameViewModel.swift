//
//  CardGameViewModel.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 27..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

protocol CardGameViewModelProtocol {
    func resetGame()
    func openCardDeck()
    var cardDeckViewModel: CardDeckViewModel! { get }
    var cardStackContainerViewModel: CardStackContainerViewModel! { get }
    var wastePileViewModel: WastePileViewModel! { get }
}

class CardGameViewModel: CardGameViewModelProtocol {
    // Model
    private var cardGame: CardGame
    private(set) var cardDeckViewModel: CardDeckViewModel!
    private(set) var cardStackContainerViewModel: CardStackContainerViewModel!
    private(set) var wastePileViewModel: WastePileViewModel!
    
    init() {
        self.cardGame = CardGame()
        self.cardDeckViewModel = CardDeckViewModel(cardDeck: cardGame.cardDeck)
        self.cardStackContainerViewModel = CardStackContainerViewModel(cardStackContainer: cardGame.cardStackContainer)
        self.wastePileViewModel = WastePileViewModel(wastePile: cardGame.wastePile)
        setupNotificationObservers()
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.cardGameDidReset(_:)), name: .cardGameDidReset, object: cardGame)
        NotificationCenter.default.addObserver(self, selector: #selector(self.cardDeckOpend(_:)), name: .cardDeckOpened, object: cardGame)
        NotificationCenter.default.addObserver(self, selector: #selector(self.wastePileRecycled(_:)), name: .wastePileRecycled, object: cardGame)
    }
    
    @objc func cardGameDidReset(_ notification: Notification) {
        wastePileViewModel.initCardViewModels()
        cardDeckViewModel.initCardViewModels()
        cardStackContainerViewModel.initCardStackViewModels()
        cardStackContainerViewModel.forEach { $0.initCardViewModels() }
        NotificationCenter.default.post(name: .cardGameVMDidReset, object: self)
    }
    
    @objc func cardDeckOpend(_ notification: Notification) {
        let topCardViewModel = cardDeckViewModel.removeTopCardViewModel()
        wastePileViewModel.push(cardViewModel: topCardViewModel)
        NotificationCenter.default.post(name: .cardDeckOpened, object: self)
    }
    
    @objc func wastePileRecycled(_ notification: Notification) {
        let cardViewModels = wastePileViewModel.removeAllCardViewModels()
        cardViewModels.forEach { cardDeckViewModel.push(cardViewModel: $0) }
        NotificationCenter.default.post(name: .wastePileRecycled, object: self)
    }
    
    func resetGame() {
        cardGame.resetGame()
    }
    
    func openCardDeck() {
        cardGame.openCardDeck()
    }
}
