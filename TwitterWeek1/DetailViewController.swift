//
//  DetailViewController.swift
//  TwitterWeek1
//
//  Created by Benjamin Laddin on 8/6/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var dvcLabel: UILabel!
  
  var selectedTweet : Tweet!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    dvcLabel.text = selectedTweet.text
    
    
  }
  
}
