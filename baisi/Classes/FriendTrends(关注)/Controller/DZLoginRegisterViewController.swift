//
//  DZLoginRegisterViewController.swift
//  baisi
//
//  Created by Other on 16/2/14.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit

class DZLoginRegisterViewController: UIViewController {

    @IBOutlet weak var phoneField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        // 属性文字
//        var atts = [String : AnyObject]()
//        atts[NSForegroundColorAttributeName] = UIColor.grayColor()
//        let placeholder = NSAttributedString(string: "手机号", attributes: atts)
//        
//        phoneField.attributedPlaceholder = placeholder
    }

    @IBOutlet weak var loginViewLeftMargin: NSLayoutConstraint!
    
    // 设置状态栏
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func back(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func showLoginOrRegister(sender: UIButton) {
        view.endEditing(true)
        
        if loginViewLeftMargin.constant == 0 { // 注册界面
            loginViewLeftMargin.constant = -view.width
            sender.selected = true
        } else { // 登录界面
            loginViewLeftMargin.constant = 0
            sender.selected = false
        }
        
        UIView.animateWithDuration(0.25) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
}
