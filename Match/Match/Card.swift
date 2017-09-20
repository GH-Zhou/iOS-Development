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
//    {
//        didSet {
//            // when any is set to cardValue, set the UIImage to the image that represents the value
//            cardImageView.image = UIImage(named: cardNames[cardValue])
//        }
//    }
    let cardNames = ["card2", "card3", "card4", "card5", "card6", "card7", "card8", "card9", "card10", "jack", "queen", "king", "ace"]
    
    // UIView, the superclass already has init() method
    // Called when creating an object with code
    override init(frame: CGRect) {
        super.init(frame: frame) // reason for calling this: don't wanna lose class UIView's initialization
        
        // Custom functionality
        
        // Add imageView into view
        addSubview(cardImageView) // adding "view." will raise error because Card class is already a subclass of UIView
        
        // Initialize the image view with an image
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        cardImageView.image = UIImage(named: "back")
        
        // Set constraints to the UIImageView
        let heightConstraint = NSLayoutConstraint(item: cardImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 170)
        
        let widthConstraint = NSLayoutConstraint(item: cardImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120)
        
        cardImageView.addConstraints([heightConstraint, widthConstraint])
        
        let topConstraint = NSLayoutConstraint(item: cardImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0) // self refers to Card class
        
        let leftConstraint = NSLayoutConstraint(item: cardImageView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        
        addConstraints([topConstraint, leftConstraint]) // call self
    }
    
    // If the following code is not added, an error will be raised:
    //    'required' initializer 'init(coder:)' must be provided by subclass of 'UIView'
    
    // Called when creating an object with storyboard
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
    
    
    func flipUp() {
        cardImageView.image = UIImage(named: cardNames[cardValue])
    }

}
