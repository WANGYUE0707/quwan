//
//  NSDateExtension.swift
//  baisi
//
//  Created by 朱颖宇 on 16/2/17.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import Foundation

extension NSDate {
    func deltaFrom(from: NSDate)-> NSDateComponents {
        
        // 当前的日历
        let calendar = NSCalendar.currentCalendar()
        // 比较时间
        let unit: NSCalendarUnit = [.Year, .Month, .Day, .Hour, .Minute, .Second]
            return calendar.components(unit, fromDate: from, toDate: self, options: .WrapComponents)
    }
    
    func isThisYear() -> Bool {
        let calendar = NSCalendar.currentCalendar()
        
        let nowYear = calendar.component(.Year, fromDate: NSDate())
        let selfYear = calendar.component(.Year, fromDate: self)
        
        return nowYear == selfYear ? true : false
    }
    
    func isToday() -> Bool {
        let fmt = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        
        let nowStr = fmt.stringFromDate(NSDate())
        let selfStr = fmt.stringFromDate(self)
        
        debugPrint("\(nowStr)===\(selfStr)")
        
        return nowStr == selfStr ? true : false
    }
    
    func isYesterday() -> Bool {
        let fmt = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        
        let nowDate = fmt.dateFromString(fmt.stringFromDate(NSDate()))
        let selfDate = fmt.dateFromString(fmt.stringFromDate(self))
        
        // 当前的日历
        let calendar = NSCalendar.currentCalendar()
        // 比较时间
        let unit: NSCalendarUnit = [.Year, .Month, .Day, .Hour, .Minute, .Second]
        let cmp = calendar.components(unit, fromDate: selfDate!, toDate: nowDate!, options: .WrapComponents)
        debugPrint("\(cmp.year)==\(cmp.month)==\(cmp.day)")
        return (cmp.year == 0 && cmp.month == 0 && cmp.day == 1) ? true : false
    }
    
}
