//
//  ReservationDatabase.swift
//  WAEAT_prototype3
//
//  Created by Lee Junho on 2014. 11. 4..
//  Copyright (c) 2014년 Lee Junho. All rights reserved.
//

import Foundation

class ReservationDatabase {
    
    var jsonData : NSData!
    
    init() {
        // initializer
    }
    
    // get list of registered stores from database
    func getUserReservation(userID : NSString) -> [AnyObject] {
        var content : NSString = NSString(format: "userID=%@", userID)
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://release.sogang.ac.kr/~dangercloz/reservation/userReservation.php")!)
        request.HTTPMethod = "POST"
        request.HTTPBody = content.dataUsingEncoding(NSUTF8StringEncoding)
        
        var jsonData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)!
        var jsonObjects = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as? [AnyObject]
        
        return jsonObjects!
    }
    
    // add reservation to database
    func addUserReservation(userID : NSString, storeID : NSString, waiter : Int, requestText : NSString) {
        var content : NSString = NSString(format: "userID=%@&storeID=%@&waiter=%d&request=%@", userID, storeID, waiter, requestText)
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://release.sogang.ac.kr/~dangercloz/reservation/addReservation.php")!)
        request.HTTPMethod = "POST"
        request.HTTPBody = content.dataUsingEncoding(NSUTF8StringEncoding)
        
        var jsonData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)!
    }
    
    // cancel reservation
    func cancelUserReservation(purchaseID : NSString) {
        var content = NSString(format: "purchaseID=%@", purchaseID)
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://release.sogang.ac.kr/~dangercloz/reservation/cancelReservation.php")!)
        request.HTTPMethod = "POST"
        request.HTTPBody = content.dataUsingEncoding(NSUTF8StringEncoding)
        
        var jsonData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)!
    }
    
}