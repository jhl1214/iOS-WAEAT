//
//  WEEventTableViewCell.swift
//  WAEAT_prototype3
//
//  Created by Lee Junho on 2014. 11. 4..
//  Copyright (c) 2014년 Lee Junho. All rights reserved.
//

import UIKit

class WEEventTableViewCell : UITableViewCell, UIScrollViewDelegate {
    
    var cellHeight : CGFloat!
    var pageControl : UIPageControl!
    var scrollView : UIScrollView!
    var eventContentArray : NSMutableArray!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeLayout() {
        contentView.frame.size.height = cellHeight
        
        scrollView = UIScrollView(frame: CGRectMake(0, 0, contentView.frame.size.width, cellHeight))
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollEnabled = true
        scrollView.pagingEnabled = true
        contentView.addSubview(scrollView)
        
        initializeEventContent()
        
        pageControl = UIPageControl(frame: CGRectMake((contentView.frame.size.width - 150) / 2, (cellHeight - 25), 150, 20))
        pageControl.numberOfPages = eventContentArray.count
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        contentView.addSubview(pageControl)
        
        scrollView.contentSize = CGSizeMake((contentView.frame.size.width * CGFloat(eventContentArray.count)), cellHeight)
    }
    
    func initializeEventContent() {
        eventContentArray = NSMutableArray()
        
        for(var i=0;i<3;i++) {
            var contentPositionX = contentView.frame.size.width * CGFloat(i)
            var imageView = UIImageView(frame: CGRectMake(contentPositionX, 0, contentView.frame.size.width, cellHeight))
            imageView.image = UIImage(named: NSString(format: "temp%d.png", i))
            scrollView.addSubview(imageView)
            eventContentArray.addObject(imageView)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var stopIndex : Int = Int(scrollView.contentOffset.x / contentView.frame.size.width)
        pageControl.currentPage = stopIndex
    }
    
}