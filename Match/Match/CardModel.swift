//
//  CardModel.swift
//  Match
//
//  Created by Hendrik Zhou on 2017/9/18.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit

class CardModel: NSObject {
    
    func getCards() -> [Card] {
        
        var cardArray = [Card]()
        
        for _ in 1...8 {
            
            let randomNumber = Int(arc4random_uniform(13))
            
            // Generate Card pair of objects
            let cardOne = Card()
            cardOne.cardValue = randomNumber
            
            let cardTwo = Card()
            cardTwo.cardValue = randomNumber
            
            // Place card objects into cardArray
            cardArray += [cardOne, cardTwo]
        }
        
        // Randomize the cardArray
        for index in 0...cardArray.count-1 {
            
            // generate a random index
            let randomIndex = Int(arc4random_uniform(UInt32(cardArray.count)))
            
            // swap the objects
            let temp = cardArray[index]
            cardArray[index] = cardArray[randomIndex]
            cardArray[randomIndex] = temp
        }
        
        return cardArray
    }
}
