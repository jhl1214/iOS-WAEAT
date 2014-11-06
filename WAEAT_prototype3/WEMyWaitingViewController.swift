//
//  WEMyWaitingViewController.swift
//  WAEAT_prototype3
//
//  Created by Lee Junho on 2014. 11. 1..
//  Copyright (c) 2014년 Lee Junho. All rights reserved.
//

import UIKit

class WEMyWaitingViewController : UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myReservationListArray : NSMutableArray!
    var reservationCellHeight : CGFloat = 110
    var eventCellHeight : CGFloat = 100
    var userID : NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userID = NSUserDefaults.standardUserDefaults().valueForKey("userID") as NSString
        userID = "20141014001"
        
        myReservationListArray = NSMutableArray()
        updateReservationListArray()
        
        self.navigationItem.title = "마이웨이팅"
        
        // initialize the refresh control
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.refreshControl?.tintColor = UIColor.blackColor()
        self.refreshControl?.addTarget(self, action: "getLatestUpdate", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        myReservationListArray.removeAllObjects()
        
        updateReservationListArray()
        
        self.tableView.reloadData()
    }
    
    func updateReservationListArray() {
        // get my reservation list from database
        for elem : AnyObject in ReservationDatabase().getUserReservation(userID) {
            var reservationItem = ReservationObject()
            
            reservationItem.purchaseID = elem["purchaseNumber"] as NSString
            reservationItem.userID = elem["userNumber"] as NSString
            reservationItem.purchaseDate = elem["purchaseDate"] as NSString
            reservationItem.storeID = elem["storeNumber"] as NSString
            reservationItem.waiterNumber = elem["people"] as NSString
            reservationItem.request = elem["request"] as NSString
            
            myReservationListArray.addObject(reservationItem)
        }
    }
    
    func getLatestUpdate() {
        // reload reservation information
        myReservationListArray.removeAllObjects()
        
        updateReservationListArray()
        
        reloadData()
    }
    
    func reloadData() {
        // reload table data
        self.tableView.reloadData()
        
        // end the refreshing
        if ((self.refreshControl) != nil) {
            var formatter = NSDateFormatter()
            formatter.dateFormat = "MMM d, h:mm a"
            
            var title = NSString(format: "Last update: %@", formatter.stringFromDate(NSDate()))
            var attrsDictionary = NSDictionary(object: UIColor.blackColor(), forKey: NSForegroundColorAttributeName)
            var attributedTitle = NSAttributedString(string: title, attributes: attrsDictionary)
            self.refreshControl?.attributedTitle = attributedTitle
            
            self.refreshControl?.endRefreshing()
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // returns number of sections for the tableview
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0:
            // returns number of rows for my reservation
            return myReservationListArray.count
        case 1:
            // returns number of rows for current event tab
            return 1
        case 2:
            // returns number of rows for near place
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // returns title for sections
        switch(section) {
        case 0:
            // returns title of section for my reservation
            return "마이웨이팅 현황"
        case 1:
            // returns title of section for current event tab
            return "이벤트"
        case 2:
            // returns title of section for near place
            return "주변 카페"
        default:
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch(indexPath.section) {
        case 0:
            // returns height of rows for my reservation section
            return reservationCellHeight
        case 1:
            // returns height of rows for current event section
            return eventCellHeight
        case 2:
            // returns height of rows for near place section
            return 44
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var identifier : NSString!
        
        if(indexPath.section == 0) {
            identifier = NSString(format: "%@", myReservationListArray.objectAtIndex(indexPath.row).purchaseID)
        } else {
            identifier = NSString(format: "s%i-r%i", indexPath.section, indexPath.row)
        }
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as UITableViewCell!
        
        if(cell == nil) {
            switch(indexPath.section) {
            case 0:
                // cell for reservation cell
                var reservationCell = WEMyWaitingTableViewCell(style: .Default, reuseIdentifier: identifier)
                reservationCell.cellHeight = reservationCellHeight
                reservationCell.storeID = myReservationListArray.objectAtIndex(indexPath.row).storeID
                reservationCell.initializeLayout()
                reservationCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                cell = reservationCell
            case 1:
                // cell for event cell
                var eventCell = WEEventTableViewCell(style: .Default, reuseIdentifier: identifier)
                eventCell.cellHeight = eventCellHeight
                eventCell.initializeLayout()
                eventCell.selectionStyle = UITableViewCellSelectionStyle.None
                cell = eventCell
            case 2:
                // cell for near place cell
                cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
            default:
                cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
            }
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 0) {
            // move to detailed reservation view when touched
            let vc = WEMyReservationDetailViewController() as WEMyReservationDetailViewController
            vc.storeID = myReservationListArray.objectAtIndex(indexPath.row).storeID
            vc.reservationID = myReservationListArray.objectAtIndex(indexPath.row).purchaseID
            vc.reservationDate = myReservationListArray.objectAtIndex(indexPath.row).purchaseDate
            vc.reservationWaiter = myReservationListArray.objectAtIndex(indexPath.row).waiterNumber
            vc.reservationRequest = myReservationListArray.objectAtIndex(indexPath.row).request
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}