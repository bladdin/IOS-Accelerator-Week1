//
//  ViewController.swift
//  TwitterWeek1
//
//  Created by Benjamin Laddin on 8/3/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var tweets = [Tweet]()

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.reloadData()
    if let filePath = NSBundle.mainBundle().pathForResource("tweet", ofType: "json"){
      if let data = NSData(contentsOfFile: filePath){
        if let tweets = TweetJSONParsner.tweetsFromJSONData(data){
          self.tweets = tweets
        }
      }
    }
    
    
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

extension ViewController : UITableViewDataSource{
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath)as! UITableViewCell
    let tweet = tweets[indexPath.row]
    cell.textLabel?.text = tweet.text
    return cell
  }
  
}

