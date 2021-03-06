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
  lazy var imageQueue = NSOperationQueue()

  
  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.estimatedRowHeight = 70
    tableView.rowHeight = UITableViewAutomaticDimension
    
    tableView.dataSource = self
    tableView.reloadData()
    
    LoginService.loginForTwitter {(errorDescription, account)-> Void in
      if let errorDescription = errorDescription{
        
      }
      if let account = account{
        
          TwitterService.tweetsFromHomeTimeline(account, completionHandler: { (errorDescription, tweets) -> (Void) in
            if let tweets = tweets{
              NSOperationQueue.mainQueue().addOperationWithBlock{()-> Void in
                self.tweets = tweets
                self.tableView.reloadData()
              }
            }
          })
      }
    }
    self.view.constraints()
    
//    if let filePath = NSBundle.mainBundle().pathForResource("tweet", ofType: "json"){
//      if let data = NSData(contentsOfFile: filePath){
//        if let tweets = TweetJSONParsner.tweetsFromJSONData(data){
//          self.tweets = tweets
//        }
    
//    NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateLabels", name: UIContentSizeCategoryDidChangeNotification, object: nil)
    
  }
    
    

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
    deinit{
      
//      NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    func updateLabels(){
      self.tableView.reloadData()
    }
    
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowDeatilViewController" {
      
      if let detailViewController = segue.destinationViewController as? DetailViewController {
        if let selectedPath = self.tableView.indexPathForSelectedRow(){
       
          let rowSelected = selectedPath.row
          let selectedTweet = tweets[rowSelected]
        
          detailViewController.selectedTweet = selectedTweet
          
          
        
        
        }
      }
    }
  }
}

extension ViewController : UITableViewDataSource{
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath)as! TweetCell
    let tweet = tweets[indexPath.row]
//    cell.tweetImage = nil
    cell.usernameLabel.text = tweet.username
    //println(tweet.username)
    cell.tweetTextLabel.text = tweet.text
    cell.tweetImage = nil
    
    if let profileImage = tweet.profileImage{
      cell.tweetImage.image = profileImage
      
    }else{
      imageQueue.addOperationWithBlock({ () -> Void in
        if let imageURL = NSURL(string: tweet.profileImageURL),
          imageData = NSData(contentsOfURL: imageURL),
          image = UIImage(data: imageData){
            var size : CGSize
            switch UIScreen.mainScreen().scale{
            case 2:
              size = CGSize(width: 160, height: 160)
            case 3:
              size = CGSize(width: 240, height: 240)
            default:
              size = CGSize(width: 80, height: 80)
            }
            
            let resizedImage = ImageResizer.resizeImage(image, size: size)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              tweet.profileImage = resizedImage
              self.tweets[indexPath.row] = tweet
              if cell.tag == cell{
                cell.tweetImage = resizedImage
              }
              
            })

          }
      })
      
    }
    
    
    
  
      
      
    
    //cell.tweetImage.image = tweet.profileImageURL
//    cell.usernameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    return cell
  }
  
}

