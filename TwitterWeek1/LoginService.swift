//
//  LoginService.swift
//  TwitterWeek1
//
//  Created by Benjamin Laddin on 8/4/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import Foundation
import Accounts

class LoginService{
  class func loginForTwitter(completionHandler : (String?, ACAccount?) -> Void) {
    let accountStore = ACAccountStore()
    let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
      if let error = error{
        // error happened
        completionHandler("Please Signin", nil)
        return
      }else{
        if granted {
          if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
            completionHandler(nil, account)
          }
        }else{
          completionHandler("This app needs Twitter access", nil)
        }
      }
      
    }
    
  }
  
}