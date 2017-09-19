//
//  Card.swift
//  Match
//
//  Created by Hendrik Zhou on 2017/9/18.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit

class Card: UIView {
    
    let cardImageView = UIImageView()
    var cardValue = 0
    let cardNames = ["card2", "card3", "card4", "card5", "card6", "card7", "card8", "card9", "card10", "jack", "queen", "king", "ace"]
    
    // UIView, the superclass already has init() method
    override init(frame: CGRect) {
        super.init(frame: frame) // reason for calling this: don't wanna lose class UIView's initialization
        
        // custom functionality
        // TODO: Initialize the image view with an image
        // TODO: Add it to the view
        // TODO: Set constraints to the image view
    }
    
    // If the following code is not added, an error will be raised:
    //    'required' initializer 'init(coder:)' must be provided by subclass of 'UIView'
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
