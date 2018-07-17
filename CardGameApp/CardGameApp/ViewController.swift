//
//  ViewController.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 17..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

struct CardSize {
    static let width = UIScreen.main.bounds.width / 7 * 0.9
    static let height = CardSize.width * 1.27
}

struct ImageName {
    static let background = "bg_pattern"
    static let cardBack = "card-back"
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackGround()
        
        for order in 0..<7 {
            let cardImageView = makeCardImageView()
            view.addSubview(cardImageView)
            cardImageView.frame.origin = CGPoint(x: self.view.frame.width / 7 * CGFloat(order),
                                                 y: UIApplication.shared.statusBarFrame.height + 10)
        }
    }
    
    private func setupBackGround() {
        guard let backgroundImage = UIImage(named: ImageName.background) else { return }
        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
    }
    
    private func makeCardImageView() -> UIImageView {
        let cardImageView = UIImageView()
        cardImageView.image = UIImage(named: ImageName.cardBack)
        cardImageView.frame.size = CGSize(width: CardSize.width, height: CardSize.height)
        return cardImageView
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

