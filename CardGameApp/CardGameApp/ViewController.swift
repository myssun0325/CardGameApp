//
//  ViewController.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 17..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

struct CardSize {
    static let originXSpacing = CardSize.spacing + CardSize.width
    static let spacing: CGFloat = 5 // 카드 사이 간격
    static let width = (UIScreen.main.bounds.width - CardSize.spacing * 8) / 7
    static let height = CardSize.width * 1.27
}

struct ImageName {
    static let background = "bg_pattern"
    static let cardBack = "card-back"
    static let deckRefresh = "deck_refresh"
}

class ViewController: UIViewController {
    private var cardGameView: CardGameView!
    private var cardGameViewModel: CardGameViewModelProtocol!
    
    // MARK: Setup game background
    private func setupBackGroundPatternImage() {
        guard let backgroundImage = UIImage(named: ImageName.background) else { return }
        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackGroundPatternImage()
        cardGameViewModel = CardGameViewModel()
        cardGameView = CardGameView(viewModel: cardGameViewModel, frame: view.frame)
        view.addSubview(cardGameView)
        
        // Game Start
        cardGameView.resetGame()
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake { cardGameView.resetGame() }
    }
}

extension ViewController {
    // Set Status Bar Color
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
}
