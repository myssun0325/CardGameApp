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
    func shuffleCards()
    func removeTopCard() -> Card?
    func removeTopCards(count: Int) -> [Card]
}

class ViewController: UIViewController {
    
    private let widthSpacing: CGFloat = CardSize.width + CardSize.spacing
    private let topSpacingOfFoundationViews: CGFloat = 20
    private let topSpacingOfCardStackViews: CGFloat = 100
    private let numberOfCardStacks = 7
    
    var cardDeck: CardDeckProtocol!
    
    // MARK: CardDeckView
    lazy var cardDeckView: CardDeckView = {
        let cardDeckView = CardDeckView(frame: CGRect(x: self.view.frame.width - widthSpacing,
                           y: topSpacingOfFoundationViews,
                           width: CardSize.width, height: CardSize.height))
        return cardDeckView
    }()
    
    // MARK: FoundationCardsView
    lazy var foundationCardsView: FoundationCardsView = {
        let foundationViews = FoundationCardsView()
        foundationViews.frame = CGRect(x: CardSize.spacing, y: topSpacingOfFoundationViews,
                                       width: foundationViews.totalWidth,
                                       height: CardSize.height)
        return foundationViews
    }()
    
    // MARK: CardStacksView
    lazy var cardStacksView: CardStacksView = {
        let cardStacksView = CardStacksView()
        cardStacksView.frame = CGRect(x: CardSize.spacing,
                                      y: topSpacingOfCardStackViews,
                                      width: cardStacksView.totalWidth,
                                      height: CardSize.height)
        return cardStacksView
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
    }
    
    private func setupDefaultImages() {
        cardDeck.resetCards()
        cardDeck.shuffleCards()
        let removedCards = cardDeck.removeTopCards(count: numberOfCardStacks)
        var images = [UIImage]()
        for card in removedCards {
            card.flip()
            if let imageOfCard = card.imageOfCard() {
                images.append(imageOfCard)
            }
        }
        self.cardStacksView.setImagesOfAllStack(images)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupDefaultImages()
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            setupDefaultImages()
        }
    }
    
    // Set Status Bar Color
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
}

extension UIView {
    func setEmptyLayer() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
    }
}
