//
//  DZComment.swift
//  baisi
//
//  Created by 朱颖宇 on 16/2/26.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit

class DZComment: NSObject {
    // 音频文件时长
    var voicetime: NSNumber!
    // 评论文字
    var content: String!
    // 点赞
    var like_count: NSNumber!
    var user: DZUser!
}
