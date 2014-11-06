//
//  WEReservationConfirmViewController.swift
//  WAEAT_prototype3
//
//  Created by Lee Junho on 2014. 11. 3..
//  Copyright (c) 2014년 Lee Junho. All rights reserved.
//

import UIKit

class WEReservationConfirmViewController : UITableViewController, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate {
    
    var storeID : NSString!
    var storeName : NSString!
    var waiterNumber : Int!
    var waiterRequest : NSString!
    var userID : NSString!
    
    var cellHeight : CGFloat = 100
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userID = NSUserDefaults.standardUserDefaults().valueForKey("userID") as NSString
        userID = "20141014001"
        
        self.tableView.scrollEnabled = false
        self.navigationItem.title = "접수확인"
        self.navigationItem.hidesBackButton = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func modifyButtonPressed() {
        // move to back page
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func reservationButtonPressed() {
        // show reservation confirm alert view
        var messageLabel = NSString(format: "아래의 정보로 예약하시겠습니까?\n인원 : %d명\n요청사항 : %@", waiterNumber, waiterRequest)
        var alert = UIAlertView(title: "WAEAT!", message: messageLabel, delegate: self, cancelButtonTitle: "취소", otherButtonTitles: "확인")
        alert.tag = 0
        alert.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if(alertView.tag == 0) {
            // for reservation confirmation
            if(buttonIndex == 1) {
                // confirm button
                var alert = UIAlertView(title: "WAEAT!", message: "예약되었습니다", delegate: self, cancelButtonTitle: "확인")
                alert.tag = 1
                
                // add reservation to database
                ReservationDatabase().addUserReservation(userID, storeID: storeID, waiter: waiterNumber, requestText: waiterRequest)
                alert.show()
            }
        } else if(alertView.tag == 1) {
            // for confirm message
            if(buttonIndex == 0) {
                // confirm button
                self.tabBarController?.selectedIndex = 1
                self.navigationController?.popToRootViewControllerAnimated(false)
            }
        }
    }
    
    func reservationConfirmCell(row: Int, identifier: NSString) -> UITableViewCell {
        var cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        if(row == 0) {
            // initialize cell layout for store name
            var storeNameLabel = UILabel(frame: CGRectMake(10, 10, self.view.frame.size.width - 20, 20))
            storeNameLabel.font = UIFont.boldSystemFontOfSize(18)
            storeNameLabel.text = self.storeName
            cell.addSubview(storeNameLabel)
        } else if(row == 1) {
            // initialize cell layout for reservation detail
            var reservationTimeLabel = UILabel(frame: CGRectMake(10, 10, 80, 20))
            reservationTimeLabel.font = UIFont.systemFontOfSize(15)
            reservationTimeLabel.text = "날짜/시간"
            cell.addSubview(reservationTimeLabel)
            
            var reservationNumberLabel = UILabel(frame: CGRectMake(10, 35, 80, 20))
            reservationNumberLabel.font = UIFont.systemFontOfSize(15)
            reservationNumberLabel.text = "인원"
            cell.addSubview(reservationNumberLabel)
            
            var waiterNumberLabel = UILabel(frame: CGRectMake(90, 35, 220, 20))
            waiterNumberLabel.font = UIFont.boldSystemFontOfSize(15)
            waiterNumberLabel.text = NSString(format: "%d명", waiterNumber)
            cell.addSubview(waiterNumberLabel)
            
            var reservationRequestLabel = UILabel(frame: CGRectMake(10, 60, 80, 20))
            reservationRequestLabel.font = UIFont.systemFontOfSize(15)
            reservationRequestLabel.text = "요청사항"
            cell.addSubview(reservationRequestLabel)
            
            var requestLabel = UILabel(frame: CGRectMake(90, 60, 220, 20))
            requestLabel.font = UIFont.boldSystemFontOfSize(15)
            requestLabel.numberOfLines = 0
            requestLabel.text = self.waiterRequest
            if(self.waiterRequest != ""){
                requestLabel.sizeToFit()
            }
            
            cellHeight = requestLabel.frame.origin.y + requestLabel.frame.size.height + 10
            cell.addSubview(requestLabel)
        } else if(row == 2) {
            var modifyButton = UIButton.buttonWithType(.System) as UIButton
            modifyButton.frame = CGRectMake(10, 10, 145, 40)
            modifyButton.layer.borderWidth = 1.0
            modifyButton.layer.cornerRadius = 10.0
            modifyButton.backgroundColor = UIColor.whiteColor()
            modifyButton.setTitle("변경/취소", forState: .Normal)
            modifyButton.addTarget(self, action: "modifyButtonPressed", forControlEvents: .TouchUpInside)
            cell.addSubview(modifyButton)
            
            var reservationButton = UIButton.buttonWithType(.System) as UIButton
            reservationButton.frame = CGRectMake((modifyButton.frame.origin.x + modifyButton.frame.size.width + 10), 10, 145, 40)
            reservationButton.layer.borderWidth = 1.0
            reservationButton.layer.cornerRadius = 10.0
            reservationButton.backgroundColor = UIColor.whiteColor()
            reservationButton.setTitle("예약", forState: .Normal)
            reservationButton.addTarget(self, action: "reservationButtonPressed", forControlEvents: .TouchUpInside)
            cell.addSubview(reservationButton)
            
            cell.backgroundColor = UIColor.clearColor()
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var identifier = NSString(format: "s%i-r%i", indexPath.section, indexPath.row)
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as UITableViewCell!
        
        if(cell == nil) {
            switch(indexPath.section) {
            case 0:
                cell = reservationConfirmCell(indexPath.row, identifier: identifier)
            default:
                cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // returns number of sections for the tableview
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // returns number of rows for each section
        switch(section) {
        case 0:
            // number of rows for reservation confirm information
            return 3
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // returns height for rows in each section
        if(indexPath.section == 0) {
            // for reservation confirm section
            switch(indexPath.row) {
            case 0:
                return 40
            case 1:
                return cellHeight
            case 2:
                return 60
            default:
                return 0
            }
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // returns title for each section
        switch(section) {
        case 0:
            // returns header text for reservation confirm section
            return "마이 웨이팅"
        default:
            return nil
        }
    }
    /*
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // returns view for footer for each sections
        if(section == 0) {
            // for reservation confirm section
            let buttonView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 100))
            
            var modifyButton = UIButton.buttonWithType(.System) as UIButton
            modifyButton.frame = CGRectMake(10, 10, 155, 40)
            modifyButton.layer.borderWidth = 1.0
            modifyButton.layer.cornerRadius = 10.0
            modifyButton.backgroundColor = UIColor.whiteColor()
            modifyButton.setTitle("변경/취소", forState: .Normal)
            modifyButton.addTarget(self, action: "modifyButtonPressed", forControlEvents: .TouchUpInside)
            buttonView.addSubview(modifyButton)
            
            return buttonView
        }
        return nil
    }
*/
    
}