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

class ViewController: UIViewController {
    
    private let widthSpacing: CGFloat = CardSize.width + CardSize.spacing
    private let topSpacingOfFoundationViews: CGFloat = 20
    private let topSpacingOfCardStackViews: CGFloat = 100
    private let numberOfFoundationContainer: Int = 4
    private let numberOfCardStackViews: Int = 7
    
    var cardDeck: CardDeck!
    
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
    
    private func setupBackGroundPatternImage() {
        guard let backgroundImage = UIImage(named: ImageName.background) else { return }
        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
    }
    
    private func setup() {
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: CardSize.spacing, bottom: 0, trailing: CardSize.spacing)
        setupBackGroundPatternImage()
        view.addSubview(cardDeckView)
        view.addSubview(foundationCardsView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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
