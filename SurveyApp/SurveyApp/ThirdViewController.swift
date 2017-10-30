//
//  ThirdViewController.swift
//  SurveyApp
//
//  Created by Hendrik Zhou on 2017/10/29.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    
    var survey:Survey?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textView.delegate = self
        
        // Change corner radius of textView
        textView.layer.cornerRadius = 5.0
        
        // If survey object is not nil, then populate elements with survey results
        if let actualSurvey = survey {
            
            // Set the textView
            textView.text = actualSurvey.comments
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.resignFirstResponder()
    }
    
    // MARK: - TextView Methods
    func textViewDidEndEditing(_ textView: UITextView) {
        if let actualText = textView.text {
            // Set property for comments
            survey?.comments = actualText
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
