//
//  WEMyWaitingTableViewCell.swift
//  WAEAT_prototype3
//
//  Created by Lee Junho on 2014. 11. 4..
//  Copyright (c) 2014년 Lee Junho. All rights reserved.
//

import UIKit

class WEMyWaitingTableViewCell : UITableViewCell, UIAlertViewDelegate {
    
    var storeID : NSString!
    var storeName : NSString!
    var storeAddress : NSString!
    var storePhone : NSString!
    
    var cellHeight : CGFloat!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeLayout() {
        contentView.frame.size.height = cellHeight
        
        getStoreDetail()
        
        var storeImageView : UIImageView = UIImageView(frame: CGRectMake(10, (contentView.frame.size.height - 80) / 2, 80, 80))
        storeImageView.layer.masksToBounds = false
        storeImageView.layer.cornerRadius = storeImageView.frame.size.height / 2
        storeImageView.layer.borderWidth = 0.5
        storeImageView.layer.borderColor = UIColor.lightGrayColor().CGColor
        storeImageView.clipsToBounds = true
        storeImageView.image = UIImage(named: "")
        contentView.addSubview(storeImageView)
        
        var storeNameLabel = UILabel(frame: CGRectMake(100, 10, contentView.frame.size.width/2 + 20, 30))
        storeNameLabel.font = UIFont.boldSystemFontOfSize(20)
        storeNameLabel.adjustsFontSizeToFitWidth = true
        storeNameLabel.text = storeName
        contentView.addSubview(storeNameLabel)
        
        var locationImageView = UIImageView(frame: CGRectMake(100, 45, 15, 15))
        locationImageView.image = UIImage(named: "location.png")
        contentView.addSubview(locationImageView)
        
        var locationLabel = UILabel(frame: CGRectMake(120, 43, contentView.frame.size.width/2 + 10, 20))
        locationLabel.font = UIFont.systemFontOfSize(13)
        locationLabel.adjustsFontSizeToFitWidth = true
        locationLabel.numberOfLines = 2
        locationLabel.text = storeAddress
        contentView.addSubview(locationLabel)
        
        var paymentButton = UIButton.buttonWithType(.System) as UIButton
        paymentButton.setTitle("메뉴 선택/결제", forState: .Normal)
        paymentButton.frame = CGRectMake(100, 70, (contentView.frame.size.width / 2) + 50, 30)
        paymentButton.layer.borderWidth = 1.0
        paymentButton.layer.cornerRadius = 10.0
        paymentButton.addTarget(self, action: "paymentButtonPressed", forControlEvents: .TouchUpInside)
        contentView.addSubview(paymentButton)
    }
    
    func getStoreDetail() {
        for elem : AnyObject in StoreDatabase().getStoreDetail(storeID) {
            storeName = elem["name"] as NSString
            storeAddress = elem["address"] as NSString
            storePhone = elem["phone"] as NSString
        }
    }
    
    func paymentButtonPressed() {
        var alert = UIAlertView(title: "WAEAT!", message: "아직 지원하지 않는 기능입니다", delegate: self, cancelButtonTitle: "확인")
        alert.show()
    }
    
}