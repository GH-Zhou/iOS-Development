//
//  ViewController.swift
//  Match
//
//  Created by Hendrik Zhou on 2017/9/18.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let model = CardModel() // create a new card model
    
    var cards = [Card]() // card array can be accessed in this class SCOPE

    var stackViewArray = [UIStackView]()
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var thirdStackView: UIStackView!
    @IBOutlet weak var fourthStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Put the four stackViews into an array
        stackViewArray += [firstStackView, secondStackView, thirdStackView, fourthStackView]
        
        // Get the cards
        cards = model.getCards()
        
        // Layout the cards
        layoutCards()
    }
    
    func layoutCards() {
        
        // Keep track of which card we're at
        var cardIndex = 0
        
        // Loop through the four stackViews and put four cards into each
        for stackView in stackViewArray {
            
            // Put four cards into the stackView
            for _ in 0...3 {
                
                // Check if card exists at index before adding
                if cardIndex < cards.count {
                    
                    // Set card that we're looking at
                    let card = cards[cardIndex]
                    card.translatesAutoresizingMaskIntoConstraints = false
                    
                    // Create a gesture recognizer and attach it to the card
                    let recognizer = UITapGestureRecognizer(target: self, action: #selector(cardTapped(gestureRecognizer: )))
                    card.addGestureRecognizer(recognizer)
                    
                    // Set the size of the card object
                    let heightConstraint = NSLayoutConstraint(item: card, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 170)
                    
                    let widthConstraint = NSLayoutConstraint(item: card, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120)
                    
                    card.addConstraints([heightConstraint, widthConstraint])
                    
                    // Put one card into the stackView
                    stackView.addArrangedSubview(card)
                    cardIndex += 1
                }
                

            }
        }
    }
    
    func cardTapped(gestureRecognizer: UITapGestureRecognizer) {
        
        // Card is tapped
        let card = gestureRecognizer.view as! Card // treat view as a Card object, but kind of dangerouse cause view is an optional UIView type
        
        // Reveal card
        card.flipUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

