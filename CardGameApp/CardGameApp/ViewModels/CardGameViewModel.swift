//
//  CardGameViewModel.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 27..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class CardGameViewModel {
    // Model
    private var cardGame: CardGame
    private(set) var cardDeckViewModel: CardDeckViewModel!
    
    init() {
        self.cardGame = CardGame()
        self.cardDeckViewModel = CardDeckViewModel(cardDeck: cardGame.cardDeck)
        setupNotificationObservers()
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.gameDidReset(_:)), name: .gameDidReset, object: cardGame)
    }
    
    @objc func gameDidReset(_ notification: Notification) {
        cardDeckViewModel.initCardViewModels()
        NotificationCenter.default.post(name: .gameDidReset, object: self)
    }
    
    func resetGame() {
        cardGame.resetGame()
    }
}
