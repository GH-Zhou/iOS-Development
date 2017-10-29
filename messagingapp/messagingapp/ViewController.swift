//
//  ViewController.swift
//  messagingapp
//
//  Created by Hendrik Zhou on 2017/10/27.
//  Copyright © 2017年 Northeastern University. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    var postData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set the firebase reference
        ref = Database.database().reference()
        
        // Retrieve the posts and listen for changes
        databaseHandle = ref?.child("Posts").observe(.childAdded, with: { (snapshot) in
            
            // Code to execute when a child is added under "Posts"
            // Take the value from the snapshot and add it to the postData array
            let post = snapshot.value as? String
            if let actualPost = post {
                
                // Append the data to postData
                self.postData.append(actualPost)
                // Reload the tableView
                self.tableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel?.text = postData[indexPath.row]
        return cell!
    }


}

