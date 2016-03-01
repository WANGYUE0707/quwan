//
//  UIWindowExtension.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/11/18.
//  Copyright © 2015年 望月. All rights reserved.
//

import UIKit

extension UIWindow {
    func swichKeyWindow() {
        
        let versionKey = "CFBundleVersion"
        
        // 从偏好设置里取版本号
        let window = UIApplication.sharedApplication().keyWindow
        
        // 取当前版本号
        let currentVersion: String? = NSBundle.mainBundle().infoDictionary![versionKey] as? String
        // 保存的版本号
        let lastVersion = NSUserDefaults.standardUserDefaults().objectForKey(versionKey) as? String

        // 如果没有第一个条件，那么判断出的是bool值
        if lastVersion != nil && lastVersion == currentVersion { // 版本号相同
            window?.rootViewController = DZTabBarViewController()
        } else {
//            window?.rootViewController = DZNewFeatureViewController()
            NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: versionKey)
            NSUserDefaults.standardUserDefaults().synchronize() // 强制同步
        }
        
        // 使用可选绑定 要多一层判断 去掉
//        if let lastVersion = NSUserDefaults.standardUserDefaults().objectForKey(versionKey) as? String {
//            if lastVersion == currentVersion! { // 相同版本
//            } else {
//                window?.rootViewController = DZNewFeatureViewController()
//                NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: versionKey)
//                NSUserDefaults.standardUserDefaults().synchronize() // 强制同步
//            }
//        } else {
//            window?.rootViewController = DZNewFeatureViewController()
//            NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: versionKey)
//            NSUserDefaults.standardUserDefaults().synchronize() // 强制同步
//        }
        
        
    }
}