//
//  ViewController.swift
//  Match
//
//  Created by Hendrik Zhou on 2017/9/18.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let model = CardModel() // create a new card model
    var cards = [Card]() // card array can be accessed in this class SCOPE
    var revealedCard:Card? // either contains a Card object or nothing; track if the first card is revealed
    
    var timer:Timer?
    var countdown = 45
    
    var cardFlipSoundPlayer:AVAudioPlayer?
    var correctSoundPlayer:AVAudioPlayer?
    var wrongSoundPlayer:AVAudioPlayer?
    var shuffleSoundPlayer:AVAudioPlayer?

    var stackViewArray = [UIStackView]()
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var thirdStackView: UIStackView!
    @IBOutlet weak var fourthStackView: UIStackView!
    
    @IBOutlet weak var countdownLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Create and initialize the sound players
        do {
            
            let shuffleSoundPath = Bundle.main.path(forResource: "shuffle", ofType: "wav") // app bundle
            // An app bundle is the delivery vessel for an app. It contains the compiled code and resources in a
            // neat little package that is used for installation on a device.
            let shuffleSoundUrl = URL(fileURLWithPath: shuffleSoundPath!)
            shuffleSoundPlayer = try AVAudioPlayer(contentsOf: shuffleSoundUrl) // may throw error
            
        } // if any error is thrown, go to catch
        catch {
            // Sound player couldn't be created
        }
        
        do {
            let cardFlipSoundPath = Bundle.main.path(forResource: "cardflip", ofType: "wav")
            let cardFlipSoundUrl = URL(fileURLWithPath: cardFlipSoundPath!)
            cardFlipSoundPlayer = try AVAudioPlayer(contentsOf: cardFlipSoundUrl)
        }
        catch { }
        
        do {
            let correctSoundPath = Bundle.main.path(forResource: "dingcorrect", ofType: "wav")
            let correctSoundUrl = URL(fileURLWithPath: correctSoundPath!)
            correctSoundPlayer = try AVAudioPlayer(contentsOf: correctSoundUrl)
        }
        catch { }
        
        do {
            let wrongSoundPath = Bundle.main.path(forResource: "dingwrong", ofType: "wav")
            let wrongSoundUrl = URL(fileURLWithPath: wrongSoundPath!)
            wrongSoundPlayer = try AVAudioPlayer(contentsOf: wrongSoundUrl)
        }
        catch { }
        
        // Put the four stackViews into an array
        stackViewArray += [firstStackView, secondStackView, thirdStackView, fourthStackView]
        
        // Get the cards
        cards = model.getCards()
        
        // Layout the cards
        layoutCards()
        
        // Set the countdown label
        countdownLabel.text = String(countdown)
        
        // Create and schedule a timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true) // every second repeat until stopped
    }
    
    func timerUpdate() {
        countdown -= 1
        
        if countdown == 0 {
            // Stop the timer
            timer?.invalidate()
            
            // Stop the match game
            
            // Check if the user has matched all of the cards
            var userHasMatchedAllCards = true
            for card in cards {
                if card.isMatched == false {
                    userHasMatchedAllCards = false
                    break
                }
            }
            
            var popUpMessage = ""
            var titleText = ""
            if userHasMatchedAllCards {
                // Game is won
                titleText = "Congratulations!"
                popUpMessage = "You won!"
                
            } else {
                // Game is lost
                titleText = "Time's Up!"
                popUpMessage = "You lost!"
                
            }
            
            // Create alert
            let alert = UIAlertController(title: titleText, message: popUpMessage, preferredStyle: .alert)
            
            // Create alert action
            let alertAction = UIAlertAction(title: "Play again", style: .cancel, handler: { (alert) in
                self.restart()
            })
            let alertAction2 = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            // Attach action to alert
            alert.addAction(alertAction)
            alert.addAction(alertAction2)
            
            
            present(alert, animated: true, completion: nil)
            
        }
        
        // Update the label in the UI
        countdownLabel.text = String(countdown)
        
    }
    
    func layoutCards() {
        
        // Play shuffleSound
        shuffleSoundPlayer?.play()
        
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
        
        // Check if countdown is zero
        if countdown == 0 {
            return
        }
        
        // Card is tapped
        let card = gestureRecognizer.view as! Card // treat view as a Card object, but kind of dangerouse cause view is an optional UIView type
        
        // Check if the card is already flipped up
        if card.flippedUp == false {
            
            // Play cardFlipSound
            cardFlipSoundPlayer?.play()
            
            // Reveal card
            card.flipUp()
            
            if revealedCard == nil {
                // First card being flipped up
                
                // Track this card as the first card being flipped up
                revealedCard = card
            } else {
                // Second card being flipped up
                // optional chaining, a safeguard; even revealedCard is nil, the program won't crash
                if card.cardValue == revealedCard?.cardValue {
                    // Cards match
                    
                    // Play correctSound
                    correctSoundPlayer?.play()
                    
                    // remove both cards from the grid
                    card.isMatched = true
                    revealedCard?.isMatched = true
                    
                    // Check if all pairs have been matched
                    checkPairs()
                    
                } else {
                    // Cards don't match
                    
                    // Play wrongSound
                    wrongSoundPlayer?.play()
                    
                    // Flip both of them down again
                    let _ = Timer.scheduledTimer(timeInterval: 1, target: card, selector: #selector(Card.flipDown), userInfo: nil, repeats: false)
                    
                    let _ = Timer.scheduledTimer(timeInterval: 1, target: revealedCard!, selector: #selector(Card.flipDown), userInfo: nil, repeats: false)
                    
                }
                
                // Reset the tracking of the first card
                revealedCard = nil
            }
        }
        
    }
    
    func checkPairs() {
        
        // Check if all the pairs have been matched
        var allMatched = true
        for card in cards {
            if !card.isMatched {
                allMatched = false
                break
            }
        }
        
        // Check if it's all matched
        if allMatched {
            
            // User has won and show alert
            // Stop the timer
            timer?.invalidate()
            
            // Create alert
            let alert = UIAlertController(title: "Congratulations!", message: "You won!", preferredStyle: .alert)
            
            // Create alert action
            let alertAction = UIAlertAction(title: "Play again", style: .cancel, handler: { (alert) in
                self.restart()
            })
            let alertAction2 = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            // Attach action to alert
            alert.addAction(alertAction)
            alert.addAction(alertAction2)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func restart() {
        
        // Clear out all cards
        for card in cards {
            card.removeFromSuperview()
        }
        
        // Get the cards
        cards = model.getCards()
        
        // Layout the cards
        layoutCards()
        
        // Set the countdown label
        countdown = 45
        countdownLabel.text = String(countdown)
        
        // Create and schedule a timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true) // every second repeat until stopped
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

