//
//  ViewController.swift
//  Quiz
//
//  Created by Hendrik Zhou on 2017/9/21.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerStackView: UIStackView!
    
    // Feedback screen
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var resultViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var resultViewBottonConstraint: NSLayoutConstraint!
    
    var currentQuestion:Question?
    
    let model = QuizModel()
    
    var questions = [Question]()
    
    var numberCorrect = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Hide feedback screen
        dimView.alpha = 0
        
        // Call get questions
        questions = model.getQuestions()
        
        // Check if there are questions
        if questions.count > 0 {
            
            currentQuestion = questions[0]
            
            // Display current question
            displayCurrentQuestion()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayCurrentQuestion() {
        
        if let actualCurrentQuestion = currentQuestion {
            
            // Set question label to alpha 0
            questionLabel.alpha = 0
            
            // Set the question label
            questionLabel.text = actualCurrentQuestion.questionText
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                
                    self.questionLabel.alpha = 1
                
                }, completion: nil)
            
            // Create the answer buttons and place them into the scrollview
            createAnswerButtons()
        }
    }

    func createAnswerButtons() {
        
        if let actualCurrentQuestion = currentQuestion {
            
            for index in 0...actualCurrentQuestion.answers.count - 1 {
                
                // Create an answer button
                let answerButton = AnswerButton()
                answerButton.tag = index
                
                // Create a height constraint for it
                let heightConstraint = NSLayoutConstraint(item: answerButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
                answerButton.addConstraint(heightConstraint)
                
                // Set the answer text
                answerButton.setAnswerText(answerText: actualCurrentQuestion.answers[index])
                
                // Set the number label
                answerButton.setNumberLabel(answerNumber: index + 1)
                
                // Create and attach a tapgesturerecognizer
                let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(answerTapped(gestureRecognizer:))) // target is the ViewController
                
                answerButton.addGestureRecognizer(gestureRecognizer)
                
                // Set the answer button alpha = 0
                answerButton.alpha = 0
                
                // Place the answer button into the stackView
                answerStackView.addArrangedSubview(answerButton)
                
                // Calculate a delay based on index
                let delayAmount = Double(index) * 0.2
                
                // Fade it in
                UIView.animate(withDuration: 0.5, delay: delayAmount, options: .curveEaseOut, animations: {
                    
                    answerButton.alpha = 1
                    
                }, completion: nil)
                
            }
        }
    }
    
    func answerTapped(gestureRecognizer:UITapGestureRecognizer) {
        
        // Detect which button was tapped
        if gestureRecognizer.view as? AnswerButton != nil {
            
            // Definitely view property is not nil and is an AnswerButton object
            let answerButton = gestureRecognizer.view as! AnswerButton
            
            if answerButton.tag == currentQuestion?.correctAnswerIndex {
                // User got it correct
                resultLabel.text = "Correct!"
                
                // Set the color for the background
                resultView.backgroundColor = UIColor(red: 72/255, green: 161/255, blue: 49/255, alpha: 0.5)
                
                // Set the color for the button background
                resultButton.backgroundColor = UIColor(red: 7/255, green: 56/255, blue: 16/255, alpha: 0.5)
                
                // Increment counter
                numberCorrect += 1
            } else {
                // User got it wrong
                resultLabel.text = "Wrong!"
                
                // Set the color for the background
                resultView.backgroundColor = UIColor(red: 161/255, green: 44/255, blue: 36/255, alpha: 0.5)
                
                // Set the color for the button background
                resultButton.backgroundColor = UIColor(red: 56/255, green: 19/255, blue: 16/255, alpha: 0.5)
                
            }
            
            // Set the feedback label
            feedbackLabel.text = currentQuestion?.feedback
            
            // Set the button text
            resultButton.setTitle("Next", for: .normal) // can be .disabled
            
            // Set the constraint constants to shift the feedback view out of view
            resultViewTopConstraint.constant = 1000
            resultViewBottonConstraint.constant = -1000
            
            // layout views right away
            view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                
                // Update the constraints
                self.resultViewTopConstraint.constant = 30
                self.resultViewBottonConstraint.constant = 30
                
                self.view.layoutIfNeeded()
                
                // Show the feedback screen
                self.dimView.alpha = 1
            }, completion: nil)
            
            // Show the feedback screen
            dimView.alpha = 1
        }
        
        // gestureRecognizer.view is not an AnswerButton
        if gestureRecognizer.view != nil {
            
        }
    }
    
    @IBAction func resultButtonTapped(_ sender: Any) {
        
        // Remove the answer button
        for view in answerStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        
        // Check the text of the resultButton. If it's restart, then restart the quiz
        let currentTitle = resultButton.title(for: .normal)
        
        // Check if there's a title
        if let actualTitle = currentTitle {
            if actualTitle == "Restart" {
                // Restart the quiz
                
                
                // Set the current question to the first one
                currentQuestion = questions[0]
                displayCurrentQuestion()
                
                // Get rid of the result screen
                dimView.alpha = 0
                
                // Reset score
                numberCorrect = 0
                
                return
            }
        }
        
        // Determine what index the current question is within the question array
        let indexOfCurrentQuestion = questions.index(of: currentQuestion!)
        
        if let actualIndex = indexOfCurrentQuestion {
            // Increment the index
            let nextIndex = actualIndex + 1
            
            // Check that it's within bounds of the question array
            if nextIndex < questions.count {
                
                // Set the new current question
                currentQuestion = questions[nextIndex]
                
                // Display the next question
                displayCurrentQuestion()
                
                // Remove the dim view
                dimView.alpha = 0
            } else {
                // Quiz is over
                
                
                // Set the labels and buttons
                resultLabel.text = "Results"
                feedbackLabel.text = "Your score is \(numberCorrect) out of \(questions.count)"
                resultButton.setTitle("Restart", for: .normal)
                
                // Set the color for the background
                resultView.backgroundColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 0.5)
                
                // Set the color for the button background
                resultButton.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
                
                // Display the feedback screen
                dimView.alpha = 1
            }
        }
    }
    

}

