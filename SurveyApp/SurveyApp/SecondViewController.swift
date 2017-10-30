//
//  SecondViewController.swift
//  SurveyApp
//
//  Created by Hendrik Zhou on 2017/10/29.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // MARK: - Airport Picker properties
    @IBOutlet weak var airportButton: UIButton!
    @IBOutlet weak var airportPicker: UIPickerView!
    @IBOutlet weak var airportPickerHeight: NSLayoutConstraint!
    let airports = ["Beijing (PEK)", "Chongqing (CKG)", "Los Angeles (LAX)", "New York (JFK)"]
    
    // MARK: - Rating Properties
    @IBOutlet weak var overallRatingStepper: UIStepper!
    @IBOutlet weak var ratingLabel: UILabel!
    
    // MARK: - Slider Properties
    @IBOutlet weak var airportSlider: UISlider!
    @IBOutlet weak var airportLabel: UILabel!
    
    @IBOutlet weak var serviceSlider: UISlider!
    @IBOutlet weak var serviceLabel: UILabel!
    
    @IBOutlet weak var commercialSlider: UISlider!
    @IBOutlet weak var commercialLabel: UILabel!
    
    
    // MARK: - Other Properties
    var survey:Survey?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the pickerView
        airportPicker.delegate = self
        airportPicker.dataSource = self

        // Do any additional setup after loading the view.
        
        // Set Corner Radius for Stepper
        overallRatingStepper.layer.cornerRadius = 5.0
        
        // If survey object is not nil, then populate elements with survey results
        if let actualSurvey = survey {
            
            // Set the pickerView
            let indexOfAirport = airports.index(of: actualSurvey.airport)
            if let actualIndex = indexOfAirport {
                // Set the PickerView
                airportPicker.selectRow(actualIndex, inComponent: 0, animated: false)
                
                // Set the button text
                airportButton.setTitle(actualSurvey.airport, for: .normal)
            }
            
            // Set the rating stepper
            overallRatingStepper.value = Double(actualSurvey.overallRating)
            ratingLabel.text = "Rating: " + String(actualSurvey.overallRating)
            
            // Set the sliders
            airportSlider.value = Float(actualSurvey.airportRating)
            serviceSlider.value = Float(actualSurvey.serviceRating)
            commercialSlider.value = Float(actualSurvey.commercialRating)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        
        ratingLabel.text = "Rating: " + String(Int(sender.value))
        
        // Set property for Survey object
        survey?.overallRating = Int(sender.value)
    }
    
    // MARK: - PickerView Methods
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return airports.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attrString = NSAttributedString(string: airports[row], attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
        return attrString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // Set the button title
        airportButton.setTitle(airports[row], for: .normal)
        
        // Set property for Survey object
        survey?.airport = airports[row]
        
        // Animate the picker closed
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.25, animations: {
            
            // Animate the alpha
            self.airportPicker.alpha = 0
            self.view.layoutIfNeeded()
            
        }) { (completed) in
            
            UIView.animate(withDuration: 0.25, animations: {
                
                // Animate the height
                self.airportPickerHeight.constant = 0
                self.view.layoutIfNeeded()
            })
            
        }
    }
    
    // MARK: - Slider Methods
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        
        // Set the slider value to a "notch"
        sender.value = Float(Int(sender.value))
        
        // Grab the value from the slider and set the survey object
        if sender == airportSlider {
            survey?.airportRating = Int(sender.value)
            airportLabel.text = "Rating: " + String(Int(sender.value))
        } else if sender == serviceSlider {
            survey?.serviceRating = Int(sender.value)
            serviceLabel.text = "Rating: " + String(Int(sender.value))
        } else if sender == commercialSlider {
            survey?.commercialRating = Int(sender.value)
            commercialLabel.text = "Rating: " + String(Int(sender.value))
        }
    }
    
    
    
    // MARK: - Button Methods
    
    @IBAction func airportButtonTapped(_ sender: UIButton) {
        
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.25, animations: {
            
            // Animate the height
            self.airportPickerHeight.constant = 216
            self.view.layoutIfNeeded()
            
        }) { (completed) in
            
            // Animate the alpha
            UIView.animate(withDuration: 0.25, animations: {
                
                // Change the alpha of PickerView
                self.airportPicker.alpha = 1
                self.view.layoutIfNeeded()
            })
            
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
