//
//  NewsViewController.swift
//  nZk
//
//  Created by Hendrik Zhou on 2017/10/8.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, FeedModelDelegate, UITableViewDelegate, UITableViewDataSource {
    // Protocol: FeedModelDelegate
    
    @IBOutlet weak var tableView: UITableView!
    
    var model = FeedModel()
    var articles = [Article]()
    var selectedArticle:Article?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set the NewsViewController and the dataSource and Delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        // Kick off the Article download in the background
        model.delegate = self
        model.getArticles()
        
        // Create a UIImageView and add it to the navigation bar
        createTitleIcon()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Implement FeedModelDelegate protocol
    func articlesReady() {
        // Get the articles from the model
        articles = model.articles
    }
 
    // Implement the tableView delegate function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell to reuse
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell")!
        
        // Get article for this row
        let article = articles[indexPath.row]
        
        // Get the textLabel
        let label = cell.viewWithTag(1) as? UILabel
        if let actualLabel = label {
            
            // Set the label
            actualLabel.text = article.articleTitle
        }
        
        // If the article has an image, then try to download it
        if article.articleImageUrl != "" {
            
            // Get the imageView
            let imageView = cell.viewWithTag(2) as? UIImageView
            
            if let actualImageView = imageView {
                
                // Found the imageView, now download the image
                // Create the URL object
                let url = URL(string: article.articleImageUrl)
                
                if let actualUrl = url {
                    // Create URLRequest object
                    let request = URLRequest(url: actualUrl)
                    
                    // Grab the current URLSession
                    let session = URLSession.shared
                    
                    // Create a URLSession Data Task
                    let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
                        
                        // Fire off this work to update the UI to the main thread
                        DispatchQueue.main.async {
                            
                            // The data has been downloaded. Create a UIImage object and assign it into the imageView
                            if let actualData = data {
                                actualImageView.image = UIImage(data: actualData)
                            }
                        }
                    })
                    
                    // Fire off the Data Task
                    dataTask.resume()
                }
                
            }
        } else {
            // Article has no image url, so set the imageView to nil image
            let imageView = cell.viewWithTag(2) as? UIImageView
            
            if let actualImageView = imageView {
                actualImageView.image = UIImage(named: "NewsDefaultBackground")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // User has tapped on a row
        
        // Keep track of the selected Article
        selectedArticle = articles[indexPath.row]
        
        // Trigger the segue to go to the article detail view
        performSegue(withIdentifier: "goToNewsDetail", sender: self)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // Triggers when a segue is about to happen
        let newsDetailVC = segue.destination as! NewsDetailViewController
        newsDetailVC.articleToDisplay = selectedArticle

        // Gives you a chance to prepare the destination view controller
        
    }

}
