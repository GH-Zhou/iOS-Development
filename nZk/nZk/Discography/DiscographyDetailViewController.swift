//
//  DiscographyDetailViewController.swift
//  nZk
//
//  Created by Hendrik Zhou on 2017/10/12.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit

class DiscographyDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Detail properties
    @IBOutlet weak var discographyImageView: UIImageView!
    @IBOutlet weak var discographyTitleLabel: UILabel!
    @IBOutlet weak var discographyReleaseDataLabel: UILabel!
    @IBOutlet weak var discographyTypeLabel: UILabel!
    @IBOutlet weak var discographyPriceLabel: UILabel!
    @IBOutlet weak var discographyCatalogNumberLabel: UILabel!
    @IBOutlet weak var discographyDescriptionLabel: UILabel!
    
    // TableView for tracklist
    @IBOutlet weak var tableView: UITableView!
    
    // Storing the lists of tracklist
    var tracklist:[[String]]?
    
    // Storing the header Titles ["Disc 01", "Disc 02"...]
    var headerTitles:[String]?
    
    // Currently selected discography
    var discographyToDisplay:Discography?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createTitleIcon()
        
        // Set the dataSource and Delegate of TableView
        tableView.delegate = self
        tableView.dataSource = self
        
        // Load data
        loadData()
    }
    
    func loadData() {
        
        if let actualDiscography = discographyToDisplay {
            
            // If there exist(s) catalog number(s) --> indicating this is not a digital-only discography.
            if actualDiscography.discographyCatalogNumber.count > 0 {
                
                // The imageName of a non-digital-only discography is the catalogNumber of Disc 01
                let imageName = actualDiscography.discographyCatalogNumber[0]
                discographyImageView.image = UIImage(named: imageName)
            } else {
                
                // The imageName of a digital-only discography is the discographyTitle
                // with all spaces replaced with "_"
                let imageName = actualDiscography.discographyTitle.replacingOccurrences(of: " ", with: "_")
                discographyImageView.image = UIImage(named: imageName)
            }
            
            discographyTitleLabel.text = actualDiscography.discographyTitle
            discographyReleaseDataLabel.text = actualDiscography.discographyReleaseDate
            discographyTypeLabel.text = actualDiscography.discographyType
            
            // If the discography price is 0 (not labeled)
            if actualDiscography.discographyPrice == 0 {
                discographyPriceLabel.text = ""
            } else {
                discographyPriceLabel.text = "￥" + String(actualDiscography.discographyPrice) + "+税"
            }
            
            discographyCatalogNumberLabel.text = actualDiscography.discographyCatalogNumber.joined(separator: ",")
            discographyDescriptionLabel.text = actualDiscography.discographyDescription
            tracklist = actualDiscography.discographyTracklist
            
            // Label the header titles based on the number of discs
            headerTitles = []
            for i in 0...tracklist!.count {
                headerTitles!.append("Disc 0" + String(i+1))
            }
        }
    }
    
    // Fetch number of discs
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return tracklist!.count
    }
    
    // Fetch the number of tracks in one tracklist
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracklist![section].count
    }
    
    // Display Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell")!
        
        // Concatenate the track number with the track title
        let cellText = String(indexPath.row + 1) + ". " + tracklist![indexPath.section][indexPath.row]
        
        // Get the textLabel
        let label = cell.viewWithTag(1) as? UILabel
        if let actualLabel = label {
            // Set the label
            actualLabel.text = cellText
        }
        
        return cell
    }
    
    // Load headers of TableView
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // If the section is less than the count of headerTitles
        if section < headerTitles!.count {
            return headerTitles![section]
        }
        return nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createTitleIcon() {
        
        // Create the UIImageView
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create constraints
        let heightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 55)
        let widthConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 55)
        
        // Add constraints
        imageView.addConstraints([heightConstraint, widthConstraint])
        
        // Set the image
        imageView.image = UIImage(named: "nZkLogo")
        
        // Add it to the navigation bar
        navigationItem.titleView = imageView
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
