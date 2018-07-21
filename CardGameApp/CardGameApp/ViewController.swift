//
//  ViewController.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 17..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

struct CardSize {
    static let spacing: CGFloat = 5 // 카드 사이 간격
    static let width = (UIScreen.main.bounds.width - CardSize.spacing * 8) / 7
    static let height = CardSize.width * 1.27
}

struct ImageName {
    static let background = "bg_pattern"
    static let cardBack = "card-back"
    static let deckRefresh = "deck_refresh"
}

protocol CardDeckProtocol {
    var topCard: Card? { get }
    func resetCards()
    func removeTopCard() -> Card?
    func removeTopCards(count: Int) -> [Card]
    func addCards(_ cards: [Card])
}

protocol WastePileProtocol: CardDeckProtocol {
    func addCard(_ card: Card)
    func removeAllCards() -> [Card]
}

class ViewController: UIViewController {
    
    private let widthSpacing: CGFloat = CardSize.width + CardSize.spacing
    private let topSpacingOfFoundationViews: CGFloat = 20
    private let topSpacingOfCardStackViews: CGFloat = 100
    private let numberOfCardStacks = 7
    private let numberOfFoundations = 4
    
    var cardDeck: CardDeckProtocol = CardDeck()
    var wastePile: WastePileProtocol = CardDeck([])
    
    // MARK: CardDeckView
    lazy var cardDeckView: CardDeckView = {
        let cardDeckView = CardDeckView(frame: CGRect(x: self.view.frame.width - widthSpacing,
                           y: topSpacingOfFoundationViews,
                           width: CardSize.width, height: CardSize.height))
        return cardDeckView
    }()
    
    // MARK: FoundationCardsView
    lazy var foundationCardsView: CardContainerView<UIView> = {
        let cardContainerView = CardContainerView<UIView>(frame: CGRect(x: CardSize.spacing,
                                                                        y: topSpacingOfFoundationViews,
                                                                        width: CGFloat(numberOfFoundations) * widthSpacing,
                                                                        height: CardSize.height))
        cardContainerView.setupContainers(numberOfCards: self.numberOfFoundations)
        return cardContainerView
    }()
    
    // MARK: CardStacksView
    lazy var cardStacksView: CardContainerView<UIImageView> = {
        let cardContainerView = CardContainerView<UIImageView>(frame: CGRect(x: CardSize.spacing,
                                                                             y: topSpacingOfCardStackViews,
                                                                             width: CGFloat(numberOfCardStacks) * widthSpacing,
                                                                             height: CardSize.height))
        cardContainerView.setupContainers(numberOfCards: self.numberOfCardStacks)
        return cardContainerView
    }()
    
    // MARK: WastePileView
    lazy var wastePileView: UIImageView = {
       let wastePileView = UIImageView(frame: CGRect(x: self.view.frame.width - widthSpacing * 2,
                                                     y: topSpacingOfFoundationViews,
                                                     width: CardSize.width,
                                                     height: CardSize.height))
        wastePileView.setEmptyLayer()
        return wastePileView
    }()
    
    // MARK: setup
    private func setupBackGroundPatternImage() {
        guard let backgroundImage = UIImage(named: ImageName.background) else { return }
        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
    }
    
    private func setup() {
//        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: CardSize.spacing, bottom: 0, trailing: CardSize.spacing)
        setupBackGroundPatternImage()
        view.addSubview(cardDeckView)
        view.addSubview(foundationCardsView)
        view.addSubview(cardStacksView)
        view.addSubview(wastePileView)
    }
    
    private func setupDefaultImages() {
        cardDeck.resetCards()
        let removedCards = cardDeck.removeTopCards(count: numberOfCardStacks)
        let images = removedCards.imagesOfCards()
        self.cardStacksView.setImagesOfAllStack(images)
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.cardDeckIsEmpty(_:)), name: .cardDeckIsEmpty, object: cardDeck)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didChangeWastePile(_:)), name: .didChangeWastePile, object: wastePile)
        NotificationCenter.default.addObserver(self, selector: #selector(self.cardDeckIsFilled(_:)), name: .cardDeckIsFilled, object: cardDeck)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupDefaultImages()
        setupNotification()
        setupGestureRecognizer()
        // tap
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tappedCardDeckView(_:)))
        self.cardDeckView.addGestureRecognizer(tapRecognizer)
        
        for _ in 0..<43 {
            tappedCardDeckView(nil)
        }
    }
    
    // MARK: Event Handling
    // Shake Motion
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            setupDefaultImages()
        }
    }
    
    // Tap Gesture
    func setupGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tappedCardDeckView(_:)))
        self.cardDeckView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func tappedCardDeckView(_ sender: UITapGestureRecognizer?) {
        if let removedCard = cardDeck.removeTopCard() {
            wastePile.addCard(removedCard)
        } else {
            cardDeck.addCards(wastePile.removeAllCards())
        }
    }
    
    // MARK: Notification Handling
    @objc func cardDeckIsEmpty(_ notification: Notification) {
        updateCardDeckView(UIImage(named: ImageName.deckRefresh))
    }
    
    @objc func cardDeckIsFilled(_ notification: Notification) {
        updateCardDeckView(UIImage(named: ImageName.cardBack))
        updateWastePileView(nil)
    }

    @objc func didChangeWastePile(_ notification: Notification) {
        guard let imageName = notification.userInfo?["imageName"] as? String else { return }
        updateWastePileView(UIImage(named: imageName))
    }
    
    // MARK: View Update
    private func updateCardDeckView(_ image: UIImage?) {
        self.cardDeckView.image = image
    }
    
    private func updateWastePileView(_ image: UIImage?) {
        self.wastePileView.image = image
    }
    
    // Set Status Bar Color
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
}

extension Array where Element == Card {
    func imagesOfCards() -> [UIImage] {
        var images = [UIImage]()
        for card in self {
            if let cardImage = UIImage(named: card.nameOfCardImage()) {
                images.append(cardImage)
            }
        }
        return images
    }
}

extension Notification.Name {
    static let cardDeckIsEmpty = Notification.Name("cardDeckIsEmpty")
    static let didChangeWastePile = Notification.Name("didChangeWastePile")
    static let cardDeckIsFilled = Notification.Name("cardDeckIsFilled")
}
