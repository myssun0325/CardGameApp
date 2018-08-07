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
    var foundationContainerViewModel: FoundationContainerViewModel! { get }
}

class CardGameViewModel: CardGameViewModelProtocol {
    // Model
    private var cardGame: CardGame
    private(set) var cardDeckViewModel: CardDeckViewModel!
    private(set) var cardStackContainerViewModel: CardStackContainerViewModel!
    private(set) var wastePileViewModel: WastePileViewModel!
    private(set) var foundationContainerViewModel: FoundationContainerViewModel!
    
    init() {
        self.cardGame = CardGame()
        self.cardDeckViewModel = CardDeckViewModel(cardDeck: cardGame.cardDeck)
        self.cardStackContainerViewModel = CardStackContainerViewModel(cardStackContainer: cardGame.cardStackContainer)
        self.wastePileViewModel = WastePileViewModel(wastePile: cardGame.wastePile)
        self.foundationContainerViewModel = FoundationContainerViewModel(foundationContainer: cardGame.foundationContainer)
        setupNotificationObservers()
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.cardGameDidReset(_:)), name: .cardGameDidReset, object: cardGame)
        NotificationCenter.default.addObserver(self, selector: #selector(self.cardDeckDidOpen(_:)), name: .cardDeckDidOpen, object: cardGame)
        NotificationCenter.default.addObserver(self, selector: #selector(self.wastePileDidRecycle(_:)), name: .wastePileDidRecycle, object: cardGame)
        NotificationCenter.default.addObserver(self, selector: #selector(self.cardDidMoved(_:)), name: .cardDidMoved, object: cardGame)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.cardDidDoubleTapped(_:)), name: .cardDidDoubleTapped, object: nil)
    }
    
    @objc func cardGameDidReset(_ notification: Notification) {
        wastePileViewModel.initCardViewModels()
        cardDeckViewModel.initCardViewModels()
        foundationContainerViewModel.initFoundationDeckViewModels()
        cardStackContainerViewModel.initCardStackViewModels()
        cardStackContainerViewModel.forEach { $0.initCardViewModels() }
        NotificationCenter.default.post(name: .cardGameVMDidReset, object: self)
    }
    
    @objc func cardDeckDidOpen(_ notification: Notification) {
        let topCardViewModel = cardDeckViewModel.removeTopCardViewModel()
        wastePileViewModel.push(cardViewModel: topCardViewModel)
        NotificationCenter.default.post(name: .cardDeckVMDidOpen, object: self)
    }
    
    @objc func wastePileDidRecycle(_ notification: Notification) {
        let cardViewModels = wastePileViewModel.removeAllCardViewModels()
        cardViewModels.forEach { cardDeckViewModel.push(cardViewModel: $0) }
        NotificationCenter.default.post(name: .wastePileVMDidRecycle, object: self)
    }
    
    @objc func cardDidDoubleTapped(_ notification: Notification) {
        guard let tappedCardViewModel = notification.object as? CardViewModel else { return }
        let fromPosition = checkFromPosition(tappedCardViewModel)
        guard let toPosition = cardGame.positionToMove(card: tappedCardViewModel.card, from: fromPosition) else { return }
        cardGame.moveCard(from: fromPosition, to: toPosition)
    }
    
    @objc func cardDidMoved(_ notification: Notification) {
        guard let fromPosition = notification.userInfo?["from"] as? Position else { return }
        guard let toPostiion = notification.userInfo?["to"] as? Position else { return }
        moveCardViewModel(from: fromPosition, to: toPostiion)
        NotificationCenter.default.post(name: .cardVMDidMoved, object: self, userInfo: notification.userInfo)
    }
    
    func checkFromPosition(_ cardViewModel: CardViewModel) -> Position {
        guard let index = cardStackContainerViewModel.indexOfCardStack(cardViewModel) else {
            return Position.wastePile
        }
        return Position.cardStack(index)
    }
    
    func resetGame() {
        cardGame.resetGame()
    }
    
    func openCardDeck() {
        cardGame.openCardDeck()
    }
    
    private func popCardViewModel(from: Position) -> CardViewModel? {
        switch from {
        case .wastePile:
            return wastePileViewModel.popTopCardViewModel()
        case .cardStack(let index):
            return cardStackContainerViewModel[index].popCardViewModel()
        default:
            return nil
        }
    }
    
    private func push(cardViewModel: CardViewModel, to toPosition: Position) {
        switch toPosition {
        case .foundation(let index):
            foundationContainerViewModel.push(cardViewModel: cardViewModel, at: index)
        case .cardStack(let index):
            cardStackContainerViewModel.push(cardViewModel: cardViewModel, at: index)
        default:
            return
        }
    }
    
    private func moveCardViewModel(from fromPosition: Position, to toPosition: Position) {
        guard let popped: CardViewModel = popCardViewModel(from: fromPosition) else { return }
        push(cardViewModel: popped, to: toPosition)
    }
}
