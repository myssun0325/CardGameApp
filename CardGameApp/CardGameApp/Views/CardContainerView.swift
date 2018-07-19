//
//  CardContainerView.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 19..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

protocol CardContainer {
    func setupContainers(numberOfCards: Int)
}

class CardContainerView<T: UIView>: UIView, CardContainer {
    private let distanceOfX: CGFloat = CardSize.width + CardSize.spacing
    private var containers: [T] = []
    
    func setupContainers(numberOfCards: Int) {
        for count in 0..<numberOfCards {
            let container = T(frame: CGRect(x: CGFloat(count) * distanceOfX,
                                            y: 0,
                                            width: CardSize.width,
                                            height: CardSize.height))
            container.setEmptyLayer()
            self.containers.append(container)
            self.addSubview(container)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension CardContainerView where T == UIImageView {
    func setImagesOfAllStack(_ images: [UIImage]) {
        for index in images.indices {
            self.containers[index].image = images[index]
        }
    }
}

extension UIView {
    func setEmptyLayer() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
    }
}
