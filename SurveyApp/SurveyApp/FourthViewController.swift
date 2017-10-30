//
//  FourthViewController.swift
//  SurveyApp
//
//  Created by Hendrik Zhou on 2017/10/29.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FourthViewController: UIViewController {
    
    var survey:Survey?
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        
        // Check if there's a survey object to save
        if let actualSurvey = survey {
            // There's a survey, save it
            
            // Create a dictionary
            var d = [String:Any]()
            d["name"] = actualSurvey.name
            d["email"] = actualSurvey.email
            d["contact"] = actualSurvey.contact
            d["airport"] = actualSurvey.airport
            d["overallRating"] = actualSurvey.overallRating
            d["airportRating"] = actualSurvey.airportRating
            d["serviceRating"] = actualSurvey.serviceRating
            d["commercialRating"] = actualSurvey.commercialRating
            d["comments"] = actualSurvey.comments
            
            // Save the dictionary
            self.ref.child("surveys").childByAutoId().setValue(d)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
