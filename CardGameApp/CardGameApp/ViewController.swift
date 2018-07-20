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
}

protocol CardDeckProtocol {
    func resetCards()
    func removeTopCard() -> Card?
    func removeTopCards(count: Int) -> [Card]
}

protocol WastePileProtocol {
    func addCard(_ card: Card)
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
    
    private func setupBackGroundPatternImage() {
        guard let backgroundImage = UIImage(named: ImageName.background) else { return }
        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
    }
    
    private func setup() {
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: CardSize.spacing, bottom: 0, trailing: CardSize.spacing)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupDefaultImages()
    }
    
    // MARK: Event Handling
    // Shake Motion
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            setupDefaultImages()
        }
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
