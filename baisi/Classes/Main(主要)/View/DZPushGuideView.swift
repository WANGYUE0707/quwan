//
//  DZPushGuideView.swift
//  baisi
//
//  Created by Other on 16/2/14.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit

class DZPushGuideView: UIView {
    
    class func show() {
        let key = "CFBundleShortVersionString"
        
        // 当前软件版本号
        let currentVersion: String = NSBundle.mainBundle().infoDictionary![key] as! String
        // 沙盒中的版本号
        let sanboxVersion = (NSUserDefaults.standardUserDefaults().stringForKey(key))
     
        if currentVersion != sanboxVersion {
            let window = UIApplication.sharedApplication().keyWindow
            let guideView = self.guideView()
            guideView.frame = (window?.bounds)!
            window?.addSubview(guideView)
            
            // 存储版本号
            NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: key)
            NSUserDefaults.standardUserDefaults().synchronize() // 立即同步
            
        }
    }
 
    class func guideView() -> UIView {
        return NSBundle.mainBundle().loadNibNamed( "DZPushGuideView", owner: nil, options: nil).last as! UIView
    }
    
    
    @IBAction func close(sender: AnyObject) {
        removeFromSuperview()
    }
}
