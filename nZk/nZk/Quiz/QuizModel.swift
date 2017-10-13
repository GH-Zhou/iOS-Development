//
//  QuizModel.swift
//  nZk
//
//  Created by Hendrik Zhou on 2017/10/13.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit

class QuizModel: NSObject {

    func getQuestions() -> [Question]{
        
        var questions = [Question]()
        
        // Get array of dictionaries from JSON file
        let array = getRemoteJsonFile()
        
        // Parse dictionaries into Question objects
        for dict in array {
            
            // Create Question object
            let q = Question()
            
            // Assign question properties
            q.questionText = dict["question"] as! String // as! responds to any?
            q.answers = dict["answers"] as! [String]
            q.correctAnswerIndex = dict["correctIndex"] as! Int
            q.module = dict["module"] as! Int
            q.lesson = dict["lesson"] as! Int
            q.feedback = dict["feedback"] as! String
            
            // Add the Question object into the array
            questions += [q]
        }
        
        // Return the list of Question objects
        return questions
    }
    
    func getRemoteJsonFile() -> [[String:Any]] {
        
        do {
            // Create URL object pointing to URL of file
            let url = URL(string: "https://raw.githubusercontent.com/GH-Zhou/iOS-Development/master/nZk/nZk/Quiz/QuestionData.json")
            
            if let actualUrl = url {
                
                // Create data object using contentsOf init
                let data = try Data(contentsOf: actualUrl)
                
                // Use JSONSerialization to turn data into an array of dictionaries
                let array = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String : Any]]
                
                return array
            }
            
        }
        catch {
            // Couldn't download the json file or couldn't parse the file
        }
        
        return [[String:Any]]() // an empty array of dictionaries
    }
    
}
