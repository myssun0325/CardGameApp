//
//  FoundationDeckView.swift
//  CardGameApp
//
//  Created by moon on 2018. 8. 7..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class FoundationDeckView: UIView {
    var foundationDeckViewModel: FoundationDeckViewModel!
    private var cardViews: [CardView] = []
    
    convenience init(viewModel: FoundationDeckViewModel, frame: CGRect) {
        self.init(frame: frame)
        self.foundationDeckViewModel = viewModel
    }
}
