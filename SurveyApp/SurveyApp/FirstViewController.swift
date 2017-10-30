//
//  FirstViewController.swift
//  SurveyApp
//
//  Created by Hendrik Zhou on 2017/10/29.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - UIElements
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var contactSwitch: UISwitch!
    
    // MARK: - Other properties
    var survey:Survey?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTextField.delegate = self
        emailTextField.delegate = self
        
        // If survey object is not nil, then populate elements with survey results
        if let actualSurvey = survey {
            // Set the textFields
            nameTextField.text = actualSurvey.name
            emailTextField.text = actualSurvey.email
            
            // Set the switch
            contactSwitch.isOn = actualSurvey.contact
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Text Fild Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let actualText = textField.text {
            
            // Set the survey properties for the textFields
            if textField == nameTextField {
                survey?.name = actualText
            } else if textField == emailTextField {
                survey?.email = actualText
            }
        }
    }
    
    // MARK - Switch Methods
    @IBAction func switchToggled(_ sender: UISwitch) {
        survey?.contact = sender.isOn // whether the switch is on?
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }

}
