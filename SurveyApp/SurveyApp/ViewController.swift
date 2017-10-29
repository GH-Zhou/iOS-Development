//
//  ViewController.swift
//  SurveyApp
//
//  Created by Hendrik Zhou on 2017/10/29.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    var currentViewController:UIViewController?
    var pageIndex = 1

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
                
                switchChildViewController(fromVC: fromVC, toVC: toVC)
            }
            break
        case 2:
            // Go To Third Controller
            break
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        currentViewController = segue.destination
    }
    
    func switchChildViewController(fromVC:UIViewController, toVC:UIViewController) {
        
        // Tell the current VC that its transitioning
        fromVC.willMove(toParentViewController: nil)
        
        // Add the new VC
        self.addChildViewController(toVC)
        containerView.addSubview(toVC.view)
        
        // Move the old VC
        fromVC.view.removeFromSuperview()
        fromVC.removeFromParentViewController()
        
        // Size the frame of the toVC
        toVC.view.frame = containerView.bounds
        
        // Tell the new VC has transitioned
        toVC.didMove(toParentViewController: self)
        
        // Set the currentViewController to toVC
        currentViewController = toVC
    }

}

