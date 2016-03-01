//
//  DZTextField.swift
//  baisi
//
//  Created by Other on 16/2/14.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit


class DZTextField: UITextField {


//    override func drawPlaceholderInRect(rect: CGRect) {
//       placeholder!.drawInRect(CGRect(x: 0, y: 10, width: rect.width, height: 25), withAttributes: [
//        NSForegroundColorAttributeName : UIColor.grayColor(),
//        NSFontAttributeName : font!
//        ])
//    }
    
//    override class func initialize () {
//        getIvars()
//    }
    
    /**
//     runtime
//     */
//    class func getIvars() {
//        var count: UInt32 = 0
//        // 获取成员变量列表
//        let ivars = class_copyIvarList(UITextField.classForCoder(), &count)
//        for i in 0..<count {
//            let ivar = ivars[Int(i)]
//            
//            let name = ivar_getName(ivar)
//            
//            if let ivarName = String.fromCString(name) {
//                let ivarType = String.fromCString(ivar_getTypeEncoding(ivar))
//                debugPrint("\(ivarName)===\(ivarType!)")
//            }
//        }
//    }
//    
//    class func getPropertyList() {
//        var count: UInt32 = 0
//        // 获取属性列表
//        let pros = class_copyPropertyList(UITextField.classForCoder(), &count) // 这里不能使用self
//        for i in 0..<count {
//            let pro = pros[Int(i)]
//            let name = property_getName(pro)
//            if let proName = String.fromCString(name) {
//                let proType = String.fromCString(property_getAttributes(pro))
//                debugPrint("\(proName)====\((proType!))")
//            }
//        }
//    }
    
    override func awakeFromNib() {
        // 使得光标颜色和文字颜色一致
        tintColor = textColor
        resignFirstResponder()
    }
    
    // 成为第一响应者
    override func becomeFirstResponder() -> Bool {
        setValue(textColor, forKeyPath: "_placeholderLabel.textColor")
        return super.becomeFirstResponder()
    }
    
    // 放弃第一响应者
    override func resignFirstResponder() -> Bool {
        setValue(UIColor.grayColor(), forKeyPath: "_placeholderLabel.textColor")
        return super.resignFirstResponder()
    }
    
}
