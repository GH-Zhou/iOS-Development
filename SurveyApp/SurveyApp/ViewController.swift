//
//  ViewController.swift
//  SurveyApp
//
//  Created by Hendrik Zhou on 2017/10/29.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UIElements
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    // MARK: - Other properties
    var currentViewController:UIViewController?
    var pageIndex = 1
    var survey:Survey = Survey()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func nextTapped(_ sender: Any) {
        switch (pageIndex) {
        case 1:
            // Go To Second Controller
            let nextViewController = storyboard?.instantiateViewController(withIdentifier: "SecondVC")
            
            if let fromVC = currentViewController, let toVC = nextViewController {
                
                // Set survey object for SecondViewController
                (nextViewController as! SecondViewController).survey = survey
                
                // Switch Child View Controller
                switchChildViewController(fromVC: fromVC, toVC: toVC)
                pageIndex += 1
                setNavigation()
            }
            break
            
        case 2:
            // Go To Third Controller
            let nextViewController = storyboard?.instantiateViewController(withIdentifier: "ThirdVC")
            
            if let fromVC = currentViewController, let toVC = nextViewController {
                
                // Set survey object for ThirdViewController
                (nextViewController as! ThirdViewController).survey = survey
                
                // Switch Child View Controller
                switchChildViewController(fromVC: fromVC, toVC: toVC)
                pageIndex += 1
                setNavigation()
            }
            break
            
        case 3:
            // Go To Fourth (Final) Controller
            let nextViewController = storyboard?.instantiateViewController(withIdentifier: "FourthVC")
            
            if let fromVC = currentViewController, let toVC = nextViewController {
                
                // Set survey object for FourthViewController
                (nextViewController as! FourthViewController).survey = survey
                
                // Switch Child View Controller
                switchChildViewController(fromVC: fromVC, toVC: toVC)
                pageIndex += 1
                setNavigation()
            }
            break
            
        default:
            break
        }
    }
    
    @IBAction func backTapped(_ sender: Any) {
        switch (pageIndex) {
        case 2:
            // Go back To First Controller
            let previousViewController = storyboard?.instantiateViewController(withIdentifier: "FirstVC")
            
            if let fromVC = currentViewController, let toVC = previousViewController {
                
                // Set survey object for FirstViewController
                (previousViewController as! FirstViewController).survey = survey
                
                // Switch Child View Controller
                switchChildViewController(fromVC: fromVC, toVC: toVC)
                pageIndex -= 1
                setNavigation()
            }
            break
            
        case 3:
            // Go back To Second Controller
            let previousViewController = storyboard?.instantiateViewController(withIdentifier: "SecondVC")
            
            if let fromVC = currentViewController, let toVC = previousViewController {
                
                // Set survey object for SecondViewController
                (previousViewController as! SecondViewController).survey = survey
                
                // Switch Child View Controller
                switchChildViewController(fromVC: fromVC, toVC: toVC)
                pageIndex -= 1
                setNavigation()
            }
            break
            
        default:
            break
        }
    }
    
    
    func setNavigation() {
        
        // Set the step label
        progressLabel.text = "Step \(pageIndex) of 3"
        
        // Set the button label
        
        switch(pageIndex) {
        case 1:
            backButton.alpha = 0
            nextButton.alpha = 1
            nextButton.setTitle("Next", for:.normal)
            progressLabel.alpha = 1
            break
            
        case 2:
            backButton.alpha = 1
            nextButton.alpha = 1
            nextButton.setTitle("Next", for:.normal)
            progressLabel.alpha = 1
            break
            
        case 3:
            backButton.alpha = 1
            nextButton.alpha = 1
            nextButton.setTitle("Submit", for:.normal)
            progressLabel.alpha = 1
            break
            
        case 4:
            backButton.alpha = 0 // cannot go back once submitted
            nextButton.alpha = 0
            progressLabel.alpha = 0
            break
            
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        currentViewController = segue.destination
        (segue.destination as! FirstViewController).survey = survey
    }
    
    func switchChildViewController(fromVC:UIViewController, toVC:UIViewController) {
        
        // Tell the current VC that its transitioning
        fromVC.willMove(toParentViewController: nil)
        
        // Add the new VC
        self.addChildViewController(toVC)
        containerView.addSubview(toVC.view)
        
        // Size the frame of the toVC
        toVC.view.frame = containerView.bounds
        
        // Set the new VC alpha to 0
        toVC.view.alpha = 0
        
        // Animate the new VC alpha to 1 and the old alpha to 0
        UIView.animate(withDuration: 0.5, animations: {
            toVC.view.alpha = 1
            fromVC.view.alpha = 0
        }) { (Bool) in
            
            // Move the old VC
            fromVC.view.removeFromSuperview()
            fromVC.removeFromParentViewController()
            
            
            // Tell the new VC has transitioned
            toVC.didMove(toParentViewController: self)
            
            // Set the currentViewController to toVC
            self.currentViewController = toVC
        }
    }

}

