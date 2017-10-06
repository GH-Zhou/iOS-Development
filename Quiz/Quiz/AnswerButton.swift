//
//  AnswerButton.swift
//  Quiz
//
//  Created by Hendrik Zhou on 2017/10/2.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit

class AnswerButton: UIStackView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var numberStackView = UIStackView()
    var answerStackView = UIStackView()
    
    var numberLabel = UILabel()
    var answerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set axis to horizontal
        axis = .horizontal
        
        // Initialize answer label and stackView
        answerStackView.addArrangedSubview(answerLabel)
        answerStackView.alignment = .center
        addArrangedSubview(answerStackView)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAnswerText(answerText:String) {
        // Set the answer label
        answerLabel.textAlignment = .center
        answerLabel.text = answerText
        
        
    }
    
}
