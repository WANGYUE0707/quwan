//
//  DoubleExtension.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/11/24.
//  Copyright © 2015年 望月. All rights reserved.
//

import Foundation

// 输出格式化
extension Double {
    func format(f f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
