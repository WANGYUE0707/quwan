//
//  DZRecommendCategory.swift
//  baisi
//
//  Created by Other on 16/2/11.
//  Copyright © 2016年 wangyue. All rights reserved.
//  左边的数据模型

import UIKit

class DZRecommendCategory: NSObject {
    
    var id: NSNumber?
    var count: NSNumber?
    var name: String?
    
    lazy var users: NSMutableArray? = NSMutableArray()
    
    var total: NSNumber?
 /// 当前页码
    var currentPage: NSNumber?
    
    
}
