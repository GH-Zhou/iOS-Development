//
//  FeedModel.swift
//  nZk
//
//  Created by Hendrik Zhou on 2017/10/8.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit

protocol FeedModelDelegate { // customized protocol
    func articlesReady()
}

class FeedModel: NSObject, XMLParserDelegate { // protocol is after ","
    
    var url = "http://www.sh-nzk.net/xml/artInfoRSS.php?id=70007946"
    var articles = [Article]()
    
    var delegate:FeedModelDelegate? // should be NewsViewController in this case
    
    // Parsed variables
    var newArticle:Article?
    var newString = ""
    var linkAttributes = [String:String]() // Dictionary
    
    func getArticles() {
        
        // Download the RSS feed
        let feedURL = URL(string: url)
        if let actualFeedUrl = feedURL {
            let parser = XMLParser(contentsOf: actualFeedUrl)
            
            if let actualParser = parser {
                
                // set the feedModel as the parser delegate
                actualParser.delegate = self
                
                actualParser.parse()
            }
        }
    }
    
    // Delegation function: called when the parser finds a new starting tag
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        // We only care about the Item, Title, Description and Link
        if elementName == "item" {
            newArticle = Article()
        } else if elementName == "link" {
            linkAttributes = attributeDict
        }
    }
    
    // Delegation function: called when the parser finds a character between two tags
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        // We only want to save the characters, if the current tag is Title, Description or Link
        if newArticle != nil {
            newString += string
        }
    }
    
    // Delegation function: called when the parser finds an ending tag
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        // Do something when the ending tag is Item, Title, Description or Link only
        if elementName == "title" {
            
            let title = newString.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Save the newString as the Title for newArticle
            newArticle?.articleTitle = title
        } else if elementName == "description" {
            
            // Save the newString as the body for newArticle
            newArticle?.articleBody = newString
            
            // Search for HTTP
            if let startRange = newString.range(of: "http") {
                
                // Found http. Now look for .jpg or .png
                if let endRange = newString.range(of: ".jpg") {
                    
                    // Found .jpg. Now get the substring
                    let substring = newString[startRange.lowerBound..<endRange.upperBound]
                    newArticle?.articleImageUrl = String(substring)
                } else if let endRange = newString.range(of: ".png") {
                    
                    // Found .png. Now get the substring
                    let substring = newString[startRange.lowerBound..<endRange.upperBound]
                    newArticle?.articleImageUrl = String(substring)
                }
            }
            
        } else if elementName == "link" {
            
            // Save the newString as the article url for newArticle
            newArticle?.articleLink = newString.trimmingCharacters(in: .whitespacesAndNewlines)
            
        } else if elementName == "item" {
            
            // Save the newArticle into the array
            if let actualNewArticle = newArticle {
                articles.append(actualNewArticle)
            }
            
            // Reset the newArticle variable
            newArticle = nil
        }
        
        // Reset the newString variable
        newString = ""
    }
    
    // Delegation function: called when the parser finishes parsing the feed
    func parserDidEndDocument(_ parser: XMLParser) {
        
        // When the feed is parsed, we want to notify the delegate
        // Check if the delegate is nil, if not, call articlesReady()
        if let actualDelegate = delegate {
            actualDelegate.articlesReady()
        }
    }
}
