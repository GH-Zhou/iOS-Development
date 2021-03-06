//
//  Card.swift
//  Match
//
//  Created by Hendrik Zhou on 2017/9/18.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit

class Card: UIView {
    
    let backImageView = UIImageView()
    let frontImageView = UIImageView()
    
    var cardValue = 0
//    {
//        didSet {
//            // when any is set to cardValue, set the UIImage to the image that represents the value
//            cardImageView.image = UIImage(named: cardNames[cardValue])
//        }
//    }
    let cardNames = ["card1", "card2", "card3", "card4", "card5", "card6", "card7", "card8", "card9", "card10", "card11", "card12", "card13"]
    
    var flippedUp = false
    var isMatched = false {
        didSet {
            if isMatched {
                // Remove the image from the cardImageView
                
                UIView.animate(withDuration: 1, delay: 1, options: .curveEaseOut, animations: {
                    self.backImageView.alpha = 0
                    self.frontImageView.alpha = 0
                }, completion: nil)

            }
        }
    }
    
    // UIView, the superclass already has init() method
    // Called when creating an object with code
    override init(frame: CGRect) {
        super.init(frame: frame) // reason for calling this: don't wanna lose class UIView's initialization
        
        // Custom functionality
        
        // Add imageView into view
        addSubview(backImageView) // adding "view." will raise error because Card class is already a subclass of UIView
        
        // Initialize the image view with an image
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        backImageView.image = UIImage(named: "back")
        
        // Set constraints to the backImageView
        applySizeConstraints(imageView: backImageView)
        applyPositionConstraints(imageView: backImageView)
        
        // Add frontImageView into view
        addSubview(frontImageView)
        frontImageView.translatesAutoresizingMaskIntoConstraints = false
        applySizeConstraints(imageView: frontImageView)
        applyPositionConstraints(imageView: frontImageView)
        
    }
    
    func applySizeConstraints(imageView:UIImageView) {
        
        let heightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 170)
        
        let widthConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120)
        
        imageView.addConstraints([heightConstraint, widthConstraint])
    }
    
    func applyPositionConstraints(imageView:UIImageView) {
        
        let topConstraint = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0) // self refers to Card class
        
        let leftConstraint = NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        
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
        
        // Set the front card image
        frontImageView.image = UIImage(named: cardNames[cardValue])
        
        // Run the transition animation
        UIView.transition(from: backImageView, to: frontImageView, duration: 1, options: .transitionFlipFromLeft, completion: nil)
        
        applyPositionConstraints(imageView: frontImageView)
        
        // Set the flag
        flippedUp = true
    }
    
    func flipDown() {
        
        // Run the transition animation
        UIView.transition(from: frontImageView, to: backImageView, duration: 1, options: .transitionFlipFromLeft, completion: nil)
        
        applyPositionConstraints(imageView: backImageView)
        
        // Set the flag
        flippedUp = false
    }

}
