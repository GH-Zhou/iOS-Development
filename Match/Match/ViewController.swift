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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cards = model.getCards()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

