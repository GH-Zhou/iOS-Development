//
//  DiscographyModel.swift
//  nZk
//
//  Created by Hendrik Zhou on 2017/10/10.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit

class DiscographyModel: NSObject {
    
    func getDiscographies() -> [Discography] {
        
        var discographies = [Discography]()
        
        // Get an array of dictionaries from JSON file
        let array = getRemoteJsonFile()
        
        // Parse dictionaries into Discography objects
        for dict in array {
            let d = Discography() // new Discography object
            
            // Assign Discography fields
            d.discographyTitle = dict["discographyTitle"] as! String
            d.discographyReleaseDate = dict["discographyReleaseDate"] as! String
            d.discographyType = dict["discographyType"] as! String
            d.discographyPrice = dict["discographyPrice"] as! Int
            d.discographyDescription = dict["discographyDescription"] as! String
            d.discographyTracklist = dict["discographyTracklist"] as! [[String]]
            d.discographyCatalogNumber = dict["discographyCatalogNumber"] as! [String]
            d.discographyImageUrl = dict["discographyImageUrl"] as! String
            
            discographies += [d]
        }
        
        return discographies
    }
    
    func getRemoteJsonFile() -> [[String:Any]] {
        
        do {
            // Create URL object pointing to the URL of the file
            let url = URL(string: "https://raw.githubusercontent.com/GH-Zhou/iOS-Development/master/nZk/nZk/Discography/DiscographyData.json")
            
            if let actualUrl = url {
                // Create data object using contentsOf init
                let data = try Data(contentsOf: actualUrl)
                
                // Use JSONSerialization to turn data into an array of dictionaries
                let array = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String:Any]]
                
                return array
            }
        }
        catch {
            // Error happened
        }
        
        return [[String:Any]]()
    }
    
}
