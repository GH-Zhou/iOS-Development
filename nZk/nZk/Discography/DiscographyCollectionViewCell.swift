//
//  DiscographyCollectionViewCell.swift
//  nZk
//
//  Created by Hendrik Zhou on 2017/10/11.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit

class DiscographyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var discographyImageView: UIImageView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var discographyTitleLabel: UILabel!
    
    var discography:Discography? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI()
    {
        if let actualDiscography = discography {
            
            if actualDiscography.discographyCatalogNumber.count > 0 {
                
                let imageName = actualDiscography.discographyCatalogNumber[0]
                discographyImageView.image = UIImage(named: imageName)
            } else {
                
                let imageName = actualDiscography.discographyTitle.replacingOccurrences(of: " ", with: "_")
                discographyImageView.image = UIImage(named: imageName)
            }
            discographyTitleLabel.text = discography?.discographyTitle
        }
        
    }
}
