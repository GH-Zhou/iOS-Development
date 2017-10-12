//
//  NewsDetailViewController.swift
//  nZk
//
//  Created by Hendrik Zhou on 2017/10/8.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit
import WebKit

class NewsDetailViewController: UIViewController, WKUIDelegate {

    var articleToDisplay:Article?
    
    @IBOutlet var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let article = articleToDisplay {
            
            // if article exists, load it in the webView
            
            // Create URL object
            let url = URL(string: article.articleLink)
            
            if let actualUrl = url {
                // if URL object exists, create URLRequest object
                let request = URLRequest(url: actualUrl)
                
                // Load the request in the webView
                webView.load(request)
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
