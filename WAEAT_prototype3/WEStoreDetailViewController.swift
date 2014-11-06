//
//  WEStoreDetailViewController.swift
//  WAEAT_prototype3
//
//  Created by Lee Junho on 2014. 10. 31..
//  Copyright (c) 2014년 Lee Junho. All rights reserved.
//

import UIKit

class WEStoreDetailViewController : UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var storeID : NSString!
    var storeName : NSString!
    var storeAddress : NSString!
    var storePhone : NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "매장정보"
        self.tableView.backgroundColor = UIColor.whiteColor()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        // initialize the refresh control
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.refreshControl?.tintColor = UIColor.blackColor()
        self.refreshControl?.addTarget(self, action: "getLatestUpdate", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var identifier = NSString(format: "s%i-r%i", indexPath.section, indexPath.row)
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as UITableViewCell!
        
        if(cell == nil) {
            switch(indexPath.section) {
            case 0:
                // create cell for store detail view
                cell = initializeLayout(identifier)
            default:
                cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
            }
        }
        
        return cell
    }
    
    func initializeLayout(identifier : NSString) -> UITableViewCell {
        var cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        // image view for store interial
        var storeInterialImageView = UIImageView(frame: CGRectMake(10, 10, cell.frame.size.width - 20, 180))
        var imageData = NSData(contentsOfURL: NSURL(string: "http://openimage.interpark.com/2011/mcoffee/poi/seoga007/1.jpg")!)
        storeInterialImageView.image = UIImage(data: imageData!)
        cell.addSubview(storeInterialImageView)
        
        // store name label
        var storeNameLabel = UILabel(frame: CGRectMake(30, (storeInterialImageView.frame.origin.y + storeInterialImageView.frame.size.height + 10), cell.frame.size.width - 100, 25))
        storeNameLabel.font = UIFont.boldSystemFontOfSize(20)
        storeNameLabel.adjustsFontSizeToFitWidth = true
        storeNameLabel.text = storeName
        cell.addSubview(storeNameLabel)
        
        // telephone button
        var callButton = UIButton.buttonWithType(.System) as UIButton
        callButton.setImage(UIImage(named: "phone.png"), forState: .Normal)
        callButton.frame = CGRectMake((storeNameLabel.frame.origin.x + storeNameLabel.frame.size.width + 10), (storeInterialImageView.frame.origin.y + storeInterialImageView.frame.size.height + 10), 25, 25)
        callButton.addTarget(self, action: "callingEvent", forControlEvents: .TouchUpInside)
        cell.addSubview(callButton)
        
        // location image view
        var storeLocationImageView = UIImageView(frame: CGRectMake(storeNameLabel.frame.origin.x, (storeNameLabel.frame.origin.y + storeNameLabel.frame.size.height + 10), 15, 15))
        storeLocationImageView.image = UIImage(named: "location.png")
        cell.addSubview(storeLocationImageView)
        
        // location address label
        var storeLocationLabel = UILabel(frame: CGRectMake((storeLocationImageView.frame.origin.x + storeLocationImageView.frame.size.width + 5), (storeNameLabel.frame.origin.y + storeNameLabel.frame.size.height + 5), 200, 25))
        storeLocationLabel.font = UIFont.systemFontOfSize(15)
        storeLocationLabel.adjustsFontSizeToFitWidth = true
        storeLocationLabel.text = storeAddress
        cell.addSubview(storeLocationLabel)
        
        // waiter image view
        var waiterImageView = UIImageView(frame: CGRectMake(storeNameLabel.frame.origin.x, (storeLocationImageView.frame.origin.y + storeLocationImageView.frame.size.height + 20), 30, 30))
        waiterImageView.image = UIImage(named: "people.png")
        cell.addSubview(waiterImageView)
        
        // waiter label
        var waiterLabel = UILabel(frame: CGRectMake((waiterImageView.frame.origin.x + waiterImageView.frame.size.width + 5), (storeLocationImageView.frame.origin.y + storeLocationImageView.frame.size.height + 25), 110, 20))
        waiterLabel.font = UIFont.systemFontOfSize(18)
        waiterLabel.adjustsFontSizeToFitWidth = true
        waiterLabel.text = "XX명"
        cell.addSubview(waiterLabel)
        
        // time image view
        var timeImageView = UIImageView(frame: CGRectMake((cell.frame.size.width / 2) + (waiterImageView.frame.origin.x / 2), (storeLocationImageView.frame.origin.y + storeLocationImageView.frame.size.height + 20), 30, 30))
        timeImageView.image = UIImage(named: "time.png")
        cell.addSubview(timeImageView)
        
        // time label
        var timeLabel = UILabel(frame: CGRectMake((timeImageView.frame.origin.x + timeImageView.frame.size.width + 5), (storeLocationImageView.frame.origin.y + storeLocationImageView.frame.size.height + 25), 110, 20))
        timeLabel.font = UIFont.systemFontOfSize(18)
        timeLabel.adjustsFontSizeToFitWidth = true
        timeLabel.text = "XX분"
        cell.addSubview(timeLabel)
        
        // waiting button
        var waitingButton = UIButton.buttonWithType(.System) as UIButton
        waitingButton.setTitle("웨이팅하기", forState: .Normal)
        waitingButton.frame = CGRectMake(10, (waiterImageView.frame.origin.y + waiterImageView.frame.size.height + 30), (cell.frame.size.width - 20), 50)
        waitingButton.layer.masksToBounds = true
        waitingButton.layer.cornerRadius = 10.0
        waitingButton.layer.borderWidth = 1.0
        waitingButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        waitingButton.addTarget(self, action: "waitingButtonEvent", forControlEvents: .TouchUpInside)
        cell.addSubview(waitingButton)
        
        return cell
    }
    
    func callingEvent() {
        // make a call to store
        var phoneNumber = NSString(format: "telprompt://%@", storePhone)
        UIApplication.sharedApplication().openURL(NSURL(string: phoneNumber)!)
    }
    
    func waitingButtonEvent() {
        // move to reservation page
        let vc = WEReservationViewController() as WEReservationViewController
        vc.storeID = self.storeID
        vc.storeName = self.storeName
        vc.storeAddress = self.storeAddress
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getLatestUpdate() {
        // reload store detail (waiter and time remaining)
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
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // returns number of rows for each section
        switch(section) {
        case 0:
            // for store detail view cell
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // returns height of cell for each sections
        switch(indexPath.section) {
        case 0:
            // height of cell for store detail section
            return 500
        default:
            return 0
        }
    }
    
}