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
    private let topSpacingOfFoundationView: CGFloat = 20
    private let numberOfFoundationContainer: Int = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: CardSize.spacing, bottom: 0, trailing: CardSize.spacing)
        setupBackGroundPatternImage()
        setupFoundationConatinerViews()
    }
    
    private func setupBackGroundPatternImage() {
        guard let backgroundImage = UIImage(named: ImageName.background) else { return }
        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
    }
    
    private func setupFoundationConatinerViews() {
        for count in 0..<numberOfFoundationContainer {
            let foundationView = UIView()
            foundationView.frame = CGRect(x: self.view.directionalLayoutMargins.leading + CGFloat(count) * widthSpacing,
                                          y: topSpacingOfFoundationView,
                                          width: CardSize.width,
                                          height: CardSize.height)
            foundationView.layer.cornerRadius = 5
            foundationView.layer.borderColor = UIColor.white.cgColor
            foundationView.layer.borderWidth = 1
            foundationView.layer.masksToBounds = true
            view.addSubview(foundationView)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

