//
//  WEReservationViewController.swift
//  WAEAT_prototype3
//
//  Created by Lee Junho on 2014. 11. 1..
//  Copyright (c) 2014년 Lee Junho. All rights reserved.
//

import UIKit

class WEReservationViewController : UIViewController, UIScrollViewDelegate, UITextViewDelegate {
    
    var storeID : NSString!
    var storeName : NSString!
    var storeAddress : NSString!
    var scrollView : UIScrollView!
    var waiterNumber : Int!
    
    var requestTextView : UITextView!
    var waiterCountLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        waiterNumber = 0
        initializeLayout()
        
        self.navigationItem.title = "웨이팅 접수"
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initializeLayout() {
        scrollView = UIScrollView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
        var storeNameLabel = UILabel(frame: CGRectMake(20, 10, self.view.frame.size.width - 40, 20))
        storeNameLabel.font = UIFont.boldSystemFontOfSize(20)
        storeNameLabel.adjustsFontSizeToFitWidth = true
        storeNameLabel.text = self.storeName
        scrollView.addSubview(storeNameLabel)
        
        var locationImageView = UIImageView(frame: CGRectMake(storeNameLabel.frame.origin.x, (storeNameLabel.frame.origin.y + storeNameLabel.frame.size.height + 10), 20, 20))
        locationImageView.image = UIImage(named: "location.png")
        scrollView.addSubview(locationImageView)
        
        var locationLabel = UILabel(frame: CGRectMake((locationImageView.frame.origin.x + locationImageView.frame.size.width + 5), (storeNameLabel.frame.origin.y + storeNameLabel.frame.size.height + 10), 250, 20))
        locationLabel.font = UIFont.systemFontOfSize(15)
        locationLabel.adjustsFontSizeToFitWidth = true
        locationLabel.text = self.storeAddress
        scrollView.addSubview(locationLabel)
        
        var waiterLabel = UILabel(frame: CGRectMake(storeNameLabel.frame.origin.x, (locationLabel.frame.origin.y + locationLabel.frame.size.height + 20), (self.view.frame.size.width - 40), 20))
        waiterLabel.font = UIFont.systemFontOfSize(18)
        waiterLabel.adjustsFontSizeToFitWidth = true
        waiterLabel.text = NSString(format: "%@님 외 인원선택", NSUserDefaults.standardUserDefaults().valueForKey("userName") as NSString)
        scrollView.addSubview(waiterLabel)
        
        waiterCountLabel = UILabel(frame: CGRectMake(storeNameLabel.frame.origin.x, (waiterLabel.frame.origin.y + waiterLabel.frame.size.height + 5), (self.view.frame.size.width - 40), 40))
        waiterCountLabel.layer.masksToBounds = true
        waiterCountLabel.layer.cornerRadius = 10.0
        waiterCountLabel.layer.borderWidth = 1.0
        waiterCountLabel.textAlignment = NSTextAlignment.Center
        waiterCountLabel.font = UIFont.systemFontOfSize(20)
        waiterCountLabel.text = NSString(format: "%d명", waiterNumber)
        scrollView.addSubview(waiterCountLabel)
        
        var taggingLabel = UILabel(frame: CGRectMake(storeNameLabel.frame.origin.x, (waiterCountLabel.frame.origin.y + waiterCountLabel.frame.size.height + 20), (self.view.frame.size.width - 40), 20))
        taggingLabel.font = UIFont.systemFontOfSize(18)
        taggingLabel.adjustsFontSizeToFitWidth = true
        taggingLabel.text = "참석자 지정"
        scrollView.addSubview(taggingLabel)
        
        var taggingListLabel = UILabel(frame: CGRectMake(storeNameLabel.frame.origin.x, (taggingLabel.frame.origin.y + taggingLabel.frame.size.height + 5), (self.view.frame.size.width - 40), 40))
        taggingListLabel.layer.masksToBounds = true
        taggingListLabel.layer.cornerRadius = 10.0
        taggingListLabel.layer.borderWidth = 1.0
        taggingListLabel.textAlignment = NSTextAlignment.Center
        taggingListLabel.font = UIFont.systemFontOfSize(20)
        taggingListLabel.text = "참석자 지정"
        scrollView.addSubview(taggingListLabel)
        
        var requestLabel = UILabel(frame: CGRectMake(storeNameLabel.frame.origin.x, (taggingListLabel.frame.origin.y + taggingListLabel.frame.size.height + 20), (self.view.frame.size.width - 40), 20))
        requestLabel.font = UIFont.systemFontOfSize(18)
        requestLabel.adjustsFontSizeToFitWidth = true
        requestLabel.text = "요청사항"
        scrollView.addSubview(requestLabel)
        
        requestTextView = UITextView(frame: CGRectMake(storeNameLabel.frame.origin.x, (requestLabel.frame.origin.y + requestLabel.frame.size.height + 5), (self.view.frame.size.width - 40), 100))
        requestTextView.layer.borderWidth = 1.0
        requestTextView.layer.cornerRadius = 10.0
        requestTextView.font = UIFont.systemFontOfSize(15)
        requestTextView.delegate = self
        //requestTextField.placeholder = "요청사항을 입력해주세요."
        scrollView.addSubview(requestTextView)
        
        var nextButton = UIButton.buttonWithType(.System) as UIButton
        nextButton.frame = CGRectMake(storeNameLabel.frame.origin.x, (requestTextView.frame.origin.y + requestTextView.frame.size.height + 20), (self.view.frame.size.width - 40), 40)
        nextButton.setTitle("다음", forState: .Normal)
        nextButton.layer.cornerRadius = 10.0
        nextButton.layer.borderWidth = 1.0
        nextButton.addTarget(self, action: "nextButtonPressed", forControlEvents: .TouchUpInside)
        scrollView.addSubview(nextButton)
        
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 700)
    }
    
    func nextButtonPressed() {
        // move to reservation confirm page
        let vc = WEReservationConfirmViewController(style: UITableViewStyle.Grouped) as WEReservationConfirmViewController
        vc.storeID = self.storeID
        vc.storeName = self.storeName
        vc.waiterNumber = self.waiterNumber
        vc.waiterRequest = self.requestTextView.text
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}