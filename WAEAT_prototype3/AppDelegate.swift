//
//  AppDelegate.swift
//  WAEAT_prototype3
//
//  Created by Lee Junho on 2014. 10. 31..
//  Copyright (c) 2014년 Lee Junho. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabbarController : UITabBarController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // initialize tab bar controller
        self.tabbarController = UITabBarController()
        
        // initialize home view controller with navigation controller
        var homeViewController = WEHomeViewController() as WEHomeViewController
        var navHomeViewController = UINavigationController(rootViewController: homeViewController)
        navHomeViewController.navigationBar.backgroundColor = UIColor.orangeColor()
        navHomeViewController.tabBarItem = UITabBarItem(title: "홈", image: nil, selectedImage: nil)
        
        // initialize my waiting view controller with navigation controller
        var myWaitingViewController = WEMyWaitingViewController() as WEMyWaitingViewController
        var navMyWaitingViewController = UINavigationController(rootViewController: myWaitingViewController)
        navMyWaitingViewController.navigationBar.backgroundColor = UIColor.orangeColor()
        navMyWaitingViewController.tabBarItem = UITabBarItem(title: "마이웨이팅", image: nil, selectedImage: nil)
        
        // initialize friend view controller with navigation controller
        var friendViewController = WEFriendViewController() as WEFriendViewController
        var navFriendViewController = UINavigationController(rootViewController: friendViewController)
        navFriendViewController.navigationBar.backgroundColor = UIColor.orangeColor()
        navFriendViewController.tabBarItem = UITabBarItem(title: "친구", image: nil, selectedImage: nil)
        
        // initialize my page view controller with navigation controller
        var myPageViewController = WEMyPageViewController() as WEMyPageViewController
        var navMyPageViewController = UINavigationController(rootViewController: myPageViewController)
        navMyPageViewController.navigationBar.backgroundColor = UIColor.orangeColor()
        navMyPageViewController.tabBarItem = UITabBarItem(title: "마이페이지", image: nil, selectedImage: nil)
        
        // set view controllers to tab bar controller as child view
        let controllers = [navHomeViewController, navMyWaitingViewController, navFriendViewController, navMyPageViewController]
        self.tabbarController?.viewControllers = controllers
        
        var loginViewController = WELoginViewController() as WELoginViewController
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        //self.window!.rootViewController = tabbarController
        self.window!.rootViewController = loginViewController
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

