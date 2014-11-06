//
//  StoreDatabase.swift
//  WAEAT_prototype3
//
//  Created by Lee Junho on 2014. 10. 31..
//  Copyright (c) 2014년 Lee Junho. All rights reserved.
//

import Foundation

class StoreDatabase {
    
    var jsonData : NSData!
    
    init() {
        // initializer
    }
    
    // get list of registered stores from database
    func getStoreList() -> [AnyObject]? {
        var jsonObjects : [AnyObject]!
        
        jsonData = NSData(contentsOfURL: NSURL(string: "http://release.sogang.ac.kr/~dangercloz/storeList.php")!)
        
        if(jsonData == nil) {
            jsonObjects = nil
        } else {
            jsonObjects = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as? [AnyObject]
        }
        
        return jsonObjects
    }
    
    // get individual store information from database
    func getStoreDetail(storeID : NSString) -> [AnyObject] {
        var content = NSString(format: "storeID=%@", storeID)
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://release.sogang.ac.kr/~dangercloz/store/storeDetail.php")!)
        request.HTTPMethod = "POST"
        request.HTTPBody = content.dataUsingEncoding(NSUTF8StringEncoding)
        
        var jsonData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)!
        var jsonObjects = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as? [AnyObject]
        
        return jsonObjects!
    }
    
}