//
//  DZConst.swift
//  baisi
//
//  Created by Other on 16/2/11.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit

enum DZTopicType: Int {
    case All = 1
    case Picture = 10
    case Word = 29
    case Voice = 31
    case Video = 41
}

/*
__FILE__ String The name of the file in which it appears.

__LINE__ Int The line number on which it appears.

__COLUMN__ Int The column number in which it begins.

__FUNCTION__ String The name of the declaration in which it appears.

*/

    func DZPrintFunc(functionName: String = __FUNCTION__) {
        print("\(functionName)")
    }

let DZKeyWindow = UIApplication.sharedApplication().keyWindow


let DZTitlesViewH: CGFloat = 35
let DZTitlesViewY: CGFloat = 64

let DZTopicCellMargin: CGFloat = 10
let DZTopicCellTextY: CGFloat = 55
let DZTopicCellBottomBarH: CGFloat = 44

let DZtopicCellPictureMaxH: CGFloat = 1000
let DZtopicCellPicturebreakH: CGFloat = 250

let DZtopicCellTopCmtTitleH: CGFloat = 20
