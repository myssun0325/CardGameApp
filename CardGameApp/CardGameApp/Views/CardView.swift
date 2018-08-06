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
        setupGestureRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDefault()
        setupGestureRecognizer()
    }
    
    private func setupDefault() {
        self.isUserInteractionEnabled = true
        layer.cornerRadius = 5
        layer.masksToBounds = true
        widthAnchor.constraint(equalToConstant: CardSize.width).isActive = true
        heightAnchor.constraint(equalToConstant: CardSize.height).isActive = true
    }
    
    private func setupGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didCardDoubleTapped(_:)))
        recognizer.numberOfTapsRequired = 2
        self.addGestureRecognizer(recognizer)
    }
    
    @objc func didCardDoubleTapped(_ gestureRecognizer: UIGestureRecognizer) {
        guard self.cardViewModel.isOpen else { return }
    }
}
