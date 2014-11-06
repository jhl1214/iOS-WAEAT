//
//  WELoginViewController.swift
//  WAEAT_prototype3
//
//  Created by Lee Junho on 2014. 11. 4..
//  Copyright (c) 2014년 Lee Junho. All rights reserved.
//

import UIKit

class WELoginViewController : UIViewController, UIScrollViewDelegate, UITextFieldDelegate {//UITableViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var scrollView : UIScrollView!
    var idTextField : UITextField!
    var pwTextField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeLayout()
        
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initializeLayout() {
        scrollView = UIScrollView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        scrollView.delegate = self
        var tabBackgroud = UITapGestureRecognizer(target: self, action: "resignKeyboard")
        tabBackgroud.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(tabBackgroud)
        
        self.view.addSubview(scrollView)
        
        idTextField = UITextField(frame: CGRectMake(30, (scrollView.frame.size.height / 2) - 35, scrollView.frame.size.width - 60, 30))
        idTextField.delegate = self
        idTextField.tag = 0
        idTextField.borderStyle = UITextBorderStyle.RoundedRect
        idTextField.textAlignment = NSTextAlignment.Center
        idTextField.placeholder = "ID or e-mail"
        idTextField.keyboardType = UIKeyboardType.EmailAddress
        idTextField.autocapitalizationType = UITextAutocapitalizationType.None
        idTextField.autocorrectionType = UITextAutocorrectionType.No
        scrollView.addSubview(idTextField)
        
        pwTextField = UITextField(frame: CGRectMake(30, (scrollView.frame.size.height / 2) + 5, scrollView.frame.size.width - 60, 30))
        pwTextField.delegate = self
        pwTextField.tag = 1
        pwTextField.borderStyle = UITextBorderStyle.RoundedRect
        pwTextField.textAlignment = NSTextAlignment.Center
        pwTextField.placeholder = "password"
        pwTextField.secureTextEntry = true
        scrollView.addSubview(pwTextField)
        
        var loginButton = UIButton.buttonWithType(.System) as UIButton
        loginButton.frame = CGRectMake((scrollView.frame.size.width / 2), (pwTextField.frame.origin.y + pwTextField.frame.size.height + 10), (scrollView.frame.size.width / 2) - 30, 30)
        loginButton.layer.borderWidth = 1.0
        loginButton.layer.cornerRadius = 10.0
        loginButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        loginButton.setTitle("로그인", forState: .Normal)
        loginButton.addTarget(self, action: "loginButtonPressed", forControlEvents: .TouchUpInside)
        scrollView.addSubview(loginButton)
        
        var waeatLabel = UILabel(frame: CGRectMake(0, idTextField.frame.origin.y - 40, scrollView.frame.size.width, 30))
        waeatLabel.font = UIFont.boldSystemFontOfSize(25)
        waeatLabel.textAlignment = NSTextAlignment.Center
        waeatLabel.text = "WAEAT!"
        scrollView.addSubview(waeatLabel)
    }
    
    func loginButtonPressed() {
        if(idTextField.text != "" && pwTextField.text != "") {
            // check for login success
            var loginResult : Bool = false
            
            for elem : AnyObject in UserDatabase().loginProcess(idTextField.text, userPW: pwTextField.text) {
                NSUserDefaults.standardUserDefaults().setValue(elem["userNumber"] as NSString, forKey: "userNumber")
                NSUserDefaults.standardUserDefaults().setValue(elem["name"] as NSString, forKey: "userName")
                NSUserDefaults.standardUserDefaults().setValue(elem["mail"] as NSString, forKey: "userMail")
                NSUserDefaults.standardUserDefaults().setValue(elem["id"] as NSString, forKey: "userID")
                NSUserDefaults.standardUserDefaults().setValue(elem["pw"] as NSString, forKey: "userPW")
                NSUserDefaults.standardUserDefaults().setValue(elem["phone"] as NSString, forKey: "userPhone")
                //NSUserDefaults.standardUserDefaults().setBool(true, forKey: "login")
                
                NSUserDefaults.standardUserDefaults().synchronize()
                loginResult = true
            }
            
            if(loginResult) {
                showAlertView(NSString(format: "%@님 환영합니다", NSUserDefaults.standardUserDefaults().valueForKey("userName") as NSString))
                
                let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
                appDelegate.window?.rootViewController = appDelegate.tabbarController
            } else {
                showAlertView("ID 혹은 패스워드가 틀렸습니다")
            }
        } else if(idTextField.text == "") {
            // if id section is empty
            showAlertView("ID 혹은 E-mail 주소를 입력해주세요")
        } else {
            // if pw section is empty
            showAlertView("패스워드를 입력해주세요")
        }
    }
    
    func showAlertView(message : NSString) {
        var alert = UIAlertView(title: "WAEAT!", message: message, delegate: self, cancelButtonTitle: "확인")
        alert.show()
    }
    
    func resignKeyboard() {
        if(idTextField.isFirstResponder() || pwTextField.isFirstResponder()) {
            idTextField.resignFirstResponder()
            pwTextField.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(textField.tag == 0) {
            pwTextField.becomeFirstResponder()
        } else {
            pwTextField.resignFirstResponder()
        }
        
        return true
    }
    
}