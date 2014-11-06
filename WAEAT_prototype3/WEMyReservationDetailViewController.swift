//
//  WEMyReservationDetailViewController.swift
//  WAEAT_prototype3
//
//  Created by Lee Junho on 2014. 11. 4..
//  Copyright (c) 2014년 Lee Junho. All rights reserved.
//

import UIKit

class WEMyReservationDetailViewController : UIViewController, UIAlertViewDelegate {
    
    var reservationID : NSString!
    var reservationDate : NSString!
    var reservationRequest : NSString!
    var reservationWaiter : NSString!
    
    var storeID : NSString!
    var storeName : NSString!
    var storeAddress : NSString!
    var storePhone : NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeLayout()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "예약정보"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initializeLayout() {
        getStoreDetail()
        
        var storeNameLabel = UILabel(frame: CGRectMake(20, 80, self.view.frame.size.width - 40, 20))
        storeNameLabel.font = UIFont.boldSystemFontOfSize(20)
        storeNameLabel.text = storeName
        self.view.addSubview(storeNameLabel)
        
        var reservationDateLabel = UILabel(frame: CGRectMake(storeNameLabel.frame.origin.x, (storeNameLabel.frame.origin.y + storeNameLabel.frame.size.height + 10), self.view.frame.size.width - 40, 20))
        reservationDateLabel.font = UIFont.systemFontOfSize(15)
        reservationDateLabel.text = NSString(format: "예약일자 : %@", reservationDate)
        self.view.addSubview(reservationDateLabel)
        
        var reservationWaiterLabel = UILabel(frame: CGRectMake(storeNameLabel.frame.origin.x, (reservationDateLabel.frame.origin.y + reservationDateLabel.frame.size.height + 10), self.view.frame.size.width - 40, 20))
        reservationWaiterLabel.font = UIFont.systemFontOfSize(15)
        reservationWaiterLabel.text = NSString(format: "인원수 : %@명", reservationWaiter)
        self.view.addSubview(reservationWaiterLabel)
        
        var reservationLabel = UILabel(frame: CGRectMake(storeNameLabel.frame.origin.x, (reservationWaiterLabel.frame.origin.y + reservationWaiterLabel.frame.size.height + 10), self.view.frame.size.width - 40, 20))
        reservationLabel.font = UIFont.systemFontOfSize(15)
        reservationLabel.text = "요청사항 : "
        self.view.addSubview(reservationLabel)
        
        var reservationRequestLabel = UILabel(frame: CGRectMake(storeNameLabel.frame.origin.x, (reservationLabel.frame.origin.y + reservationLabel.frame.size.height + 10), self.view.frame.size.width - 40, 60))
        reservationRequestLabel.font = UIFont.systemFontOfSize(15)
        reservationRequestLabel.numberOfLines = 0
        reservationRequestLabel.textAlignment = NSTextAlignment.Natural
        reservationRequestLabel.text = reservationRequest
        reservationRequestLabel.sizeToFit()
        self.view.addSubview(reservationRequestLabel)
        
        var cancelButton = UIButton.buttonWithType(.System) as UIButton
        cancelButton.frame = CGRectMake(20, (reservationRequestLabel.frame.origin.y + reservationRequestLabel.frame.size.height + 10), self.view.frame.size.width - 40, 40)
        cancelButton.layer.bord erWidth = 1.0
        cancelButton.layer.cornerRadius = 10.0
        cancelButton.setTitle("예약 취소", forState: .Normal)
        cancelButton.addTarget(self, action: "cancelReservation", forControlEvents: .TouchUpInside)
        self.view.addSubview(cancelButton)
        
    }
    
    func getStoreDetail() {
        for elem : AnyObject in StoreDatabase().getStoreDetail(storeID) {
            storeName = elem["name"] as NSString
            storeAddress = elem["address"] as NSString
            storePhone = elem["phone"] as NSString
        }
    }
    
    func cancelReservation() {
        var alert = UIAlertView(title: "WAEAT!", message: "취소되었습니다", delegate: self, cancelButtonTitle: "확인")
        alert.show()
        
        ReservationDatabase().cancelUserReservation(reservationID)
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
}