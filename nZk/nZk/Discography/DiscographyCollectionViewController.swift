//
//  DiscographyCollectionViewController.swift
//  nZk
//
//  Created by Hendrik Zhou on 2017/10/11.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit

class DiscographyCollectionViewController: UICollectionViewController {
    
    // Fetch data model
    let model = DiscographyModel()
    
    private let leftAndRightPaddings: CGFloat = 8.0
    private let numberOfItemsPerRow: CGFloat = 2.0
    private let heightAdjustment: CGFloat = 40.0
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = ((collectionView!.frame.width) - 4 * leftAndRightPaddings) / numberOfItemsPerRow
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width + heightAdjustment)
    }

    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.getDiscographies().count
    }
    
    private struct Storyboard {
        static let CellIdentifier = "DiscographyCell"
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.CellIdentifier, for: indexPath) as! DiscographyCollectionViewCell
        
        cell.discography = model.getDiscographies()[indexPath.item]
        
        return cell
    }
}
