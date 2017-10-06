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
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var resultButton: UIButton!
    
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
            // Set the question label
            questionLabel.text = actualCurrentQuestion.questionText
            
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
                
                // Create and attach a tapgesturerecognizer
                let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(answerTapped(gestureRecognizer:))) // target is the ViewController
                
                answerButton.addGestureRecognizer(gestureRecognizer)
                
                // Place the answer button into the stackView
                answerStackView.addArrangedSubview(answerButton)
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
                
                // Increment counter
                numberCorrect += 1
            } else {
                // User got it wrong
                resultLabel.text = "Wrong!"
            }
            
            feedbackLabel.text = currentQuestion?.feedback
            
            // TODO: Set the button text
            resultButton.setTitle("Next", for: .normal) // can be .disabled
            
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
                
                // Display the feedback screen
                dimView.alpha = 1
            }
        }
    }
    

}

