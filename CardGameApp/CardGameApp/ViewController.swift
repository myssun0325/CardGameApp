//
//  ViewController.swift
//  CardGameApp
//
//  Created by moon on 2018. 7. 17..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private struct Constants {
        static let backgroundImageName = "bg_pattern"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackGround()
    }
    
    private func setBackGround() {
        guard let image = UIImage(named: Constants.backgroundImageName) else { return }
        self.view.backgroundColor = UIColor(patternImage: image)
    }
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

