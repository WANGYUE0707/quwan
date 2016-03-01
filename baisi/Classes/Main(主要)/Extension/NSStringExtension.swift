//
//  NSStringExtension.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/11/22.
//  Copyright © 2015年 望月. All rights reserved.
//

import Foundation
import UIKit

extension NSString {
    
    func size(font: UIFont) -> CGSize {
        return size(font, maxW: 0)
    }
    
    func size(font: UIFont, maxW: CGFloat) -> CGSize {
        let attr = [
            NSFontAttributeName: font
        ]
        
        let maxSize = CGSizeMake(maxW, CGFloat(MAXFLOAT))
        return boundingRectWithSize(maxSize, options: .UsesLineFragmentOrigin, attributes: attr, context: nil).size
    }
    
}