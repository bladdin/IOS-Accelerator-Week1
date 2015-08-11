//
//  TweetJSONParsner.swift
//  TwitterWeek1
//
//  Created by Benjamin Laddin on 8/4/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import Foundation

class TweetJSONParsner{
  class func tweetsFromJSONData(jsonData : NSData) -> [Tweet]? {
    
    var error : NSError?
    
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [[String : AnyObject]]
      
    {
    var tweets = [Tweet]()
    for tweetObjects in rootObject{
      if let userInfo = tweetObjects["user"] as? [String : AnyObject],
      username = userInfo ["name"] as? String,
      text = tweetObjects ["text"] as? String,
      id = tweetObjects ["id_str"] as? String,
      //profileBackground = tweetObjects["profile_background_image_url"] as? String,
      profileImageURL = userInfo ["profile_image_url_https"] as? String{
        let tweet = Tweet(username: username, text: text, id: id, profileImageURL : profileImageURL, profileImage: nil)
        tweets.append (tweet)
      }
      
      
    }
      return tweets
    }
    return nil
  }
}