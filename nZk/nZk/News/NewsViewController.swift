//
//  NewsViewController.swift
//  nZk
//
//  Created by Hendrik Zhou on 2017/10/8.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    var model = FeedModel()
    var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Kick off the Article download in the background
        model.getArticles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
