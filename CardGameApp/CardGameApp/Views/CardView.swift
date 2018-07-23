//
//  CardView.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 23..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class CardView: UIImageView {
    private var backImage: UIImage? = UIImage(named: ImageName.cardBack)
    private var frontImage: UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setEmptyLayer()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        self.frame.size = CGSize(width: CardSize.width, height: CardSize.height)
        self.frontImage = image
        self.image = backImage
        setEmptyLayer()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frontImage = image
        self.image = backImage
        setEmptyLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.frontImage = image
        self.image = backImage
        self.setEmptyLayer()
    }
    
    func flip() {
        self.image = frontImage
    }
}
