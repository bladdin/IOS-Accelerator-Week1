//
//  TwitterService.swift
//  TwitterWeek1
//
//  Created by Benjamin Laddin on 8/5/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import Foundation
import Accounts
import Social

class TwitterService{
  class func tweetsFromHomeTimeline(account : ACAccount, completionHandler : (String?, [Tweet]?) -> (Void)){
    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json"), parameters: nil)
    request.account = account
    
    request.performRequestWithHandler{ (data, responce, error)->  Void in
      if let error = error{
        completionHandler("Could not connect to server", nil)
      }else{
        println(responce.statusCode)
        switch responce.statusCode {
        case 200...299:
          let tweets = TweetJSONParsner.tweetsFromJSONData(data)
          completionHandler(nil,tweets)
        case 400...499:
          completionHandler("Something went wrong on our end, Try again later", nil)
        case 500...599:
          completionHandler("Twitter is having some issues. Try again later", nil)
        default:
          completionHandler("An error occured, Try again later", nil)
        }
      }
    }
  }
}