//
//  ViewController.swift
//  War
//
//  Created by Hendrik Zhou on 2017/9/17.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var leftScoreLabel: UILabel!
    var leftScore = 0
    
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var rightScoreLabel: UILabel!
    var rightScore = 0
    
    let cardNames: [String] = ["card2", "card3", "card4", "card5", "card6", "card7", "card8", "card9", "card10", "jack", "queen", "king", "ace"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dealTapped(_ sender: UIButton) {
        
        // UInt32: unsigned int 32
        let leftNumber = Int(arc4random_uniform(13))
        leftImageView.image = UIImage(named: cardNames[leftNumber])
        
        let rightNumber = Int(arc4random_uniform(13))
        rightImageView.image = UIImage(named: cardNames[rightNumber])
        
        // compare
        if leftNumber > rightNumber {
            // left card wins
            
            // increment the score
            leftScore += 1
            
            // update label
            leftScoreLabel.text = String(leftScore)
            
        } else if leftNumber == rightNumber {
            // tie
            // do nothing
        } else {
            // right card wins
            
            // increment the score
            rightScore += 1
            
            // update label
            rightScoreLabel.text = String(rightScore)
        }
    }

}

