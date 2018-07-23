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
    private let numberOfFoundations = 4
    
    private var cardGame: CardGame = CardGame()
    
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
    lazy var cardStacksView: CardContainerView<UIView> = {
        let cardContainerView = CardContainerView<UIView>(frame: CGRect(x: CardSize.spacing,
                                                                             y: topSpacingOfCardStackViews,
                                                                             width: CGFloat(CardGame.numberOfCardStacks) * widthSpacing,
                                                                             height: CardSize.height))
        cardContainerView.setupContainers(numberOfCards: CardGame.numberOfCardStacks)
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
    
    private func setupEmptyViews() {
        setupBackGroundPatternImage()
        view.addSubview(cardDeckView)
        view.addSubview(foundationCardsView)
        view.addSubview(cardStacksView)
        view.addSubview(wastePileView)
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.cardDeckIsOpend(_:)), name: .cardDeckIsOpend, object: cardGame)
        NotificationCenter.default.addObserver(self, selector: #selector(self.gameReset(_:)), name: .gameReset, object: cardGame)
    }

    private func setupGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tappedCardDeckView(_:)))
        self.cardDeckView.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEmptyViews()
        setupGestureRecognizer()
        setupNotification()
        cardGame.gameReset()
    }
    
    // MARK: Event Handling
    // Shake Motion
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            cardGame.gameReset()
        }
    }
    
    // MARK: Tap Gesture Handling
    @objc func tappedCardDeckView(_ sender: UITapGestureRecognizer?) {
        cardGame.openCardDeck()
    }
    
    // MARK: Notification Handling
    @objc func cardDeckIsOpend(_ notification: Notification) {
        updateCardDeckView()
        updateWastePileView()
    }
    
    @objc func gameReset(_ notification: Notification) {
        updateCardDeckView()
        updateWastePileView()
        updateCardStacksView()
    }

    // MARK: View Update
    private func updateCardDeckView() {
        cardDeckView.image = UIImage(named: cardGame.topCardImageNameOfCardDeck())
    }
    
    private func updateWastePileView() {
        guard let name = cardGame.topCardImageNameOfWastePile() else {
            wastePileView.image = nil
            return
        }
        wastePileView.image = UIImage(named: name)
    }
    
    // 이 부분을 어떻게 처리할 수 있을까요...ㅠㅠ
    private func updateCardStacksView() {
        for (stackIndex, cardStackView) in self.cardStacksView.enumerated() {
            cardStackView.subviews.forEach { $0.removeFromSuperview() }
            for (index, card) in cardGame.cardStack(at: stackIndex).enumerated() {
                let resizeHeight = 20 * CGFloat(index)
                let cardView = CardView(image: UIImage(named: card.frontImageName))
                cardStackView.addSubview(cardView)
                cardStackView.frame.size = CGSize(width: CardSize.width,
                                                  height: CardSize.height + resizeHeight)
                cardView.frame.origin.y = resizeHeight
            }
            cardStackView.flipTopCard()
        }
    }
    
    // Set Status Bar Color
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
}

extension Notification.Name {
    static let cardDeckIsOpend = Notification.Name("carDeckIsOpend")
    static let gameReset = Notification.Name("gameReset")
}
