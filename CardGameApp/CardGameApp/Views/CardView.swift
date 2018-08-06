//
//  CardView.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 23..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class CardView: UIImageView {
    var cardViewModel: CardViewModel!
    
    convenience init(viewModel: CardViewModel, frame: CGRect) {
        self.init(frame: frame)
        self.cardViewModel = viewModel
        image = UIImage(named: ImageName.cardBack)
        highlightedImage = UIImage(named: viewModel.imageName)
        isHighlighted = viewModel.isOpen
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefault()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDefault()
    }
    
    private func setupDefault() {
        self.isUserInteractionEnabled = true
        layer.cornerRadius = 5
        layer.masksToBounds = true
        widthAnchor.constraint(equalToConstant: CardSize.width).isActive = true
        heightAnchor.constraint(equalToConstant: CardSize.height).isActive = true
    }
}
