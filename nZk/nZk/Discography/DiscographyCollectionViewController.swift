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
    
    // Selected discography
    var selectedDiscography:Discography?
    
    // Configure the dimensions of CollectionViewCell
    private let leftAndRightPaddings: CGFloat = 8.0
    private let numberOfItemsPerRow: CGFloat = 2.0
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // width of cell = (the width of coleectionView's frame - paddings) / numberOfItemsPerRow
        let width = ((collectionView!.frame.width) - 4 * leftAndRightPaddings) / numberOfItemsPerRow
        
        // Set the layout of cells
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // User has tapped on an item
        
        // Keep track of the selected Discography
        selectedDiscography = model.getDiscographies()[indexPath.item]
        
        // Trigger the segue to go to the discography detail view
        performSegue(withIdentifier: "goToDiscographyDetail", sender: self)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // Triggers when a segue is about to happen
        let discographyDetailVC = segue.destination as! DiscographyDetailViewController
        discographyDetailVC.discographyToDisplay = selectedDiscography
        
        // Gives you a chance to prepare the destination view controller
        
    }
}
