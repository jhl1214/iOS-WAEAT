//
//  WEHomeViewController.swift
//  WAEAT_prototype3
//
//  Created by Lee Junho on 2014. 10. 31..
//  Copyright (c) 2014년 Lee Junho. All rights reserved.
//

import UIKit

class WEHomeViewController : UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    let storeListCellHeight : CGFloat = 85
    
    var storeListArray : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateStoreListArray()
        
        self.navigationItem.title = "WAEAT"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateStoreListArray() {
        storeListArray = NSMutableArray()
        
        // get store information from database
        if(StoreDatabase().getStoreList() != nil) {
            for elem : AnyObject in StoreDatabase().getStoreList()! {
                var store = StoreObject()
                store.storeID = elem["storeNumber"] as NSString
                store.storeName = elem["name"] as NSString
                store.storeAddress = elem["address"] as NSString
                store.storePhone = elem["phone"] as NSString
                store.storeLogo = elem["logo"] as NSString
                storeListArray.addObject(store)
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var identifier = NSString(format: "s%i-r%i", indexPath.section, indexPath.row)
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as UITableViewCell!
        
        if(cell == nil) {
            // create initial cell for identifier
            cell = initializeStoreCellLayout(indexPath.row, identifier: identifier)
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        return cell
    }
    
    func initializeStoreCellLayout(index : Int, identifier : NSString) -> UITableViewCell {
        // initialize cell layout and data
        var cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        
        // store logo image
        var storeLogoImageView = UIImageView(frame: CGRectMake(10, 10, storeListCellHeight - 20, storeListCellHeight - 20))
        storeLogoImageView.layer.cornerRadius = storeLogoImageView.frame.size.height / 2
        storeLogoImageView.layer.borderWidth = 0.5
        storeLogoImageView.layer.borderColor = UIColor.lightGrayColor().CGColor
        storeLogoImageView.layer.masksToBounds = false
        storeLogoImageView.clipsToBounds = true
        storeLogoImageView.image = UIImage(named: "")
        cell.addSubview(storeLogoImageView)
        
        // store name
        var storeNameXOrigin = storeLogoImageView.frame.origin.x + storeLogoImageView.frame.size.width + 10
        var storeNameLabel = UILabel(frame: CGRectMake(storeNameXOrigin, 15, (cell.frame.size.width - storeNameXOrigin - 10), 20))
        storeNameLabel.font = UIFont.boldSystemFontOfSize(18)
        storeNameLabel.adjustsFontSizeToFitWidth = true
        storeNameLabel.text = storeListArray[index].storeName
        cell.addSubview(storeNameLabel)
        
        // people image
        var storePeopleYOrigin = storeNameLabel.frame.origin.y + storeNameLabel.frame.size.height + 10
        var peopleImageView = UIImageView(frame: CGRectMake(storeNameXOrigin, storePeopleYOrigin, 25, 25))
        peopleImageView.image = UIImage(named: "people.png")
        cell.addSubview(peopleImageView)
        
        // time image
        var storeTimeXOrigin = cell.frame.size.width / 2 + 30
        var timeImageView = UIImageView(frame: CGRectMake(storeTimeXOrigin, storePeopleYOrigin, 25, 25))
        timeImageView.image = UIImage(named: "time.png")
        cell.addSubview(timeImageView)
        
        // people label
        var peopleLabel = UILabel(frame: CGRectMake(storeNameXOrigin + 30, storePeopleYOrigin, 60, 25))
        peopleLabel.font = UIFont.systemFontOfSize(15)
        peopleLabel.adjustsFontSizeToFitWidth = true
        peopleLabel.text = "XX명"
        cell.addSubview(peopleLabel)
        
        // time label
        var timeLabel = UILabel(frame: CGRectMake(storeTimeXOrigin + 30, storePeopleYOrigin, 60, 25))
        timeLabel.font = UIFont.systemFontOfSize(15)
        timeLabel.adjustsFontSizeToFitWidth = true
        timeLabel.text = "XX분"
        cell.addSubview(timeLabel)
        
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // returns number of sections for table view
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // returns number of rows for each section
        switch(section) {
        case 0:
            // rows for store list section
            return storeListArray.count
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // returns height of rows for each section
        switch(indexPath.section) {
        case 0:
            // height for rows in store list section
            return storeListCellHeight
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // initialize view for store detail view
        let vc = WEStoreDetailViewController() as WEStoreDetailViewController
        vc.storeID = storeListArray[indexPath.row].storeID
        vc.storeName = storeListArray[indexPath.row].storeName
        vc.storeAddress = storeListArray[indexPath.row].storeAddress
        vc.storePhone = storeListArray[indexPath.row].storePhone
        
        // push view controller
        self.navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}