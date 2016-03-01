//
//  DZTopic.swift
//  baisi
//
//  Created by 朱颖宇 on 16/2/16.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit
import MJExtension

class DZTopic: NSObject {

    var id: String!
    var name: String?
    var profile_image: String?
    var text: String?
    var ding: NSNumber?
    var cai: NSNumber?
    var repost: NSNumber?
    var comment: NSNumber?
    var sina_v: Bool?
    
    var width: NSNumber?
    var height: NSNumber?
    var small_image: String?
    var middle_image: String?
    var large_image: String?
    var pictureF: CGRect?
    var type: NSNumber?
    
    var bigPicture: Bool?
    var pictureProgress: CGFloat? = 0
    
    /** voice */
    var voicetime: NSNumber?
    /** video */
    var videotime: NSNumber?
    
    var playcount: NSNumber?
    
    var voiceF: CGRect?
    var videoF: CGRect?
    
    var top_cmt: [AnyObject]?
    
   override class func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        return [
            "top_cmt" : DZComment.classForCoder()
        ]
    }
    
    lazy var cellHeight: CGFloat? = {
        var cellH: CGFloat? = 0
        let maxSize = CGSize(width: UIScreen.mainScreen().bounds.size.width - 4.0 * DZTopicCellMargin, height: CGFloat(MAXFLOAT))
                
        let textH = (self.text! as NSString).boundingRectWithSize(maxSize, options: .UsesLineFragmentOrigin, attributes: [
                    NSFontAttributeName : UIFont.systemFontOfSize(14)
                    ], context: nil).height
                
        cellH! += DZTopicCellTextY + textH  +  DZTopicCellMargin
                
                // 根据段子的类型来计算高度
                if self.type == DZTopicType.Picture.rawValue { // 图片贴
                    let pictureW = maxSize.width
                    var pictureH = pictureW * CGFloat(self.height!) / CGFloat(self.width!) // 通过宽高比设置高
                    
                    if pictureH >= DZtopicCellPictureMaxH {
                        pictureH = DZtopicCellPicturebreakH
                        self.bigPicture = true
                    }
                    
                    // 计算图片控件的frame
                    let pictureX = DZTopicCellMargin
                    let pictureY = DZTopicCellTextY + textH + DZTopicCellMargin
                    
                    self.pictureF = CGRect(x: pictureX, y: pictureY, width: pictureW, height: pictureH)
                    cellH! += pictureH + DZTopicCellMargin
                } else if self.type == DZTopicType.Voice.rawValue { // 声音贴
                    let voiceX = DZTopicCellMargin
                    let voiceY = DZTopicCellMargin + textH + DZTopicCellTextY
                    let voiceW = maxSize.width
                    let voiceH = voiceW * CGFloat(self.height!) / CGFloat(self.width!)
                    self.voiceF = CGRect(x: voiceX, y: voiceY, width: voiceW, height: voiceH)
                    cellH! += voiceH + DZTopicCellMargin
                    
                } else if self.type == DZTopicType.Video.rawValue {
                    let videoX = DZTopicCellMargin
                    let videoY = DZTopicCellMargin + textH + DZTopicCellTextY
                    let videoW = maxSize.width
                    let videoH = videoW * CGFloat(self.height!) / CGFloat(self.width!)
                    self.videoF = CGRect(x: videoX, y: videoY, width: videoW, height: videoH)
                    cellH! += videoH + DZTopicCellMargin
                    
                }
                
                // 热门评论
        
        if let cmt = self.top_cmt!.first as? DZComment {
            let content = "\((cmt.user!.username)!):\(cmt.content)"
            let contentH = (content as NSString).boundingRectWithSize(maxSize, options: .UsesLineFragmentOrigin, attributes: [
                NSFontAttributeName : UIFont.systemFontOfSize(14)
                ], context: nil).size.height
            
                cellH! += (DZtopicCellTopCmtTitleH + contentH + DZTopicCellMargin)
            }
        
                cellH! += (DZTopicCellMargin + DZTopicCellBottomBarH)
        
                return cellH
            }()
    
    
    
    var create_time: String? {
        
        didSet {
           let fmt = NSDateFormatter()
            fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
            // 创帖时间
            let creat = fmt.dateFromString(self.create_time!)
            
            if creat?.isYesterday() == true { // 今年
                if creat?.isToday() == true { // 今天
                    let cmps = NSDate().deltaFrom(creat!)
                    if cmps.hour >= 1 { // 时间差 > 1
                        self.create_time =  "\(cmps.hour)小时前"
                    } else if cmps.minute >= 1 { // 时间差 在1小时之内
                        self.create_time =  "\(cmps.minute)分前"
                    } else {
                        self.create_time =  "刚刚"
                    }
                } else if creat?.isYesterday() == true { // 昨天
                    fmt.dateFormat = "昨天 HH:mm:ss"
                    self.create_time =  fmt.stringFromDate(creat!)
                } else { // 其他
                    fmt.dateFormat = "MM-dd HH:mm:ss"
                    self.create_time =  fmt.stringFromDate(creat!)
                }
            } else { // 非今年
                self.create_time = fmt.stringFromDate(creat!)
            }
        }
    }
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        
        return [
            "small_image" : "image0",
            "large_image" : "image1",
            "middle_image" : "image2"
        ]
    }
}
