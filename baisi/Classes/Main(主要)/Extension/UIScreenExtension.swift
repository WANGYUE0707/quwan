//
//  UIScreenExtension.swift
//  baisi
//
//  Created by 朱颖宇 on 16/2/26.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit

extension UIScreen {
   class var width: CGFloat {
        return UIScreen.mainScreen().bounds.width
    }
    
   class var height: CGFloat {
        return UIScreen.mainScreen().bounds.height
    }
    
}
