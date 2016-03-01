//
//  DZExtension.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/8/28.
//  Copyright © 2015年 望月. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
     class func item(anction: Selector, target: NSObject?, imageName: String, highlightedImageName: String) -> UIBarButtonItem {
        let btn = UIButton(type: UIButtonType.Custom)
        btn.setBackgroundImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: highlightedImageName), forState: UIControlState.Highlighted)
        
        btn.frame.size = (btn.currentBackgroundImage?.size)!
        
        btn.addTarget(target, action: anction, forControlEvents: UIControlEvents.TouchUpInside)
        
        return UIBarButtonItem(customView: btn)
    }    
}

