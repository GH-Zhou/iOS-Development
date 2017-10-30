//
//  AnswerButton.swift
//  nZk
//
//  Created by Hendrik Zhou on 2017/10/13.
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
        
        // Initialize the number label
        numberLabel.textAlignment = .center
        numberLabel.textColor = UIColor.white
        numberLabel.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        
        let numberLabelHeight = NSLayoutConstraint(item: numberLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        numberLabel.addConstraint(numberLabelHeight)
        
        // Initialize the number label and stackView
        numberStackView.addArrangedSubview(numberLabel)
        numberStackView.alignment = .center
        addArrangedSubview(numberStackView)
        
        let widthConstraint = NSLayoutConstraint(item: numberStackView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
        numberStackView.addConstraint(widthConstraint)
        
        // Initialize answer label
        answerLabel.textAlignment = .center
        answerLabel.textColor = UIColor.white
        answerLabel.numberOfLines = 0
        answerLabel.backgroundColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 0.5)
        
        let answerLabelHeight = NSLayoutConstraint(item: answerLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        answerLabel.addConstraint(answerLabelHeight)
        
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
        answerLabel.text = answerText
        answerLabel.font = answerLabel.font.withSize(20)
    }
    
    func setNumberLabel(answerNumber:Int) {
        // Set the number label
        numberLabel.text = String(answerNumber)
        numberLabel.font = numberLabel.font.withSize(20)
    }
    
}
