//
//  WEFriendViewController.swift
//  WAEAT_prototype3
//
//  Created by Lee Junho on 2014. 11. 1..
//  Copyright (c) 2014년 Lee Junho. All rights reserved.
//

import UIKit

class WEFriendViewController : UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var friendListArray : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeLayout()
        
        self.navigationItem.title = "친구"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initializeLayout() {
        friendListArray = NSMutableArray()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // returns number of sections in the tableview
        if(friendListArray.count != 0) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            return friendListArray.count
        } else {
            // display a message when the table is empty
            var messageLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
            messageLabel.textColor = UIColor.blackColor()
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = NSTextAlignment.Center
            messageLabel.font = UIFont.systemFontOfSize(20)
            messageLabel.text = "Friend is currently disabled.\nSorry."
            messageLabel.sizeToFit()
            
            self.tableView.backgroundView = messageLabel
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            
            return 0
        }
    }
    
}