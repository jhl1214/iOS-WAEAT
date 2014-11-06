//
//  UserDatabase.swift
//  WAEAT_prototype3
//
//  Created by Lee Junho on 2014. 11. 5..
//  Copyright (c) 2014년 Lee Junho. All rights reserved.
//

import Foundation

class UserDatabase {
    
    var jsonData : NSData!
    
    init() {
        // initializer
    }
    
    // check for user login
    func loginProcess(userID : NSString, userPW : NSString) -> [AnyObject] {
        var content = NSString(format: "userID=%@&userPW=%@", userID, userPW)
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://release.sogang.ac.kr/~dangercloz/user/login.php")!)
        request.HTTPMethod = "POST"
        request.HTTPBody = content.dataUsingEncoding(NSUTF8StringEncoding)
        
        var jsonData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)!
        var jsonObjects = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as? [AnyObject]
        
        return jsonObjects!
    }
    
}