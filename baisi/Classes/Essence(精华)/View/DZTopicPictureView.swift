//
//  DZTopicPictureView.swift
//  baisi
//
//  Created by 朱颖宇 on 16/2/19.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit

class DZTopicPictureView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressView: DZProgressView!
    @IBOutlet weak var gifView: UIImageView!
    @IBOutlet weak var seeBigButton: UIButton!
    
    var topic: DZTopic? {
        willSet(topic) {
            
            imageView.kf_setImageWithURL(NSURL(string: (topic?.large_image)!)!, placeholderImage: nil, optionsInfo: nil, progressBlock: { (receivedSize, totalSize) -> () in
                self.progressView.hidden = false
                let pro = CGFloat(receivedSize) / CGFloat(totalSize)
                self.progressView.setProgress(pro, animated: false)

                }) { (image, error, cacheType, imageURL) -> () in
                    self.progressView.hidden = true
                    
                    if topic?.bigPicture == true {
                        // 开启图形上下文
                        UIGraphicsBeginImageContextWithOptions((topic?.pictureF?.size)!, true, 0.0)
                        
                        // 将图片绘制到图形上下文
                        let width = topic?.pictureF?.size.width
                        let height = width! * (image?.size.height)! / (image?.size.width)!
                        image?.drawInRect(CGRect(x: 0, y: 0, width: width!, height: height))
                        
                        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext()
                        UIGraphicsEndImageContext()
                    }
                    
            }
            
            /*
                在不知道图片扩展名的情况下,取出图片数据的第一个字节,就可以判断图片的真实类型???
            */
        
            // 判断是否是gif
            let pathExtension = ((topic?.large_image)! as NSString).pathExtension
            gifView.hidden = (pathExtension.lowercaseString == "gif") ? false : true
            
            if topic?.bigPicture == true { // 大图
                seeBigButton.hidden = false
                imageView.contentMode = .ScaleAspectFill
                imageView.clipsToBounds = true
            } else {
                seeBigButton.hidden = true
                imageView.contentMode = .ScaleToFill
            }
        }
    }
    
    @IBAction func showPicture(sender: AnyObject) {
//        if topic?.bigPicture == true {
        
        let showPicture = DZShowPictureViewController()
        showPicture.topic = topic
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(showPicture, animated: true, completion: nil)
//        }

    }

    class func pictureView() -> DZTopicPictureView {
        return NSBundle.mainBundle().loadNibNamed("DZTopicPictureView", owner: nil, options: nil).last as! DZTopicPictureView
    }
    
    override func awakeFromNib() {
        autoresizingMask = .None // 加载后尺寸不缩放
        
        // 添加手势
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "showPicture:"))
    }
}

//extension DZTopicPictureView {
//    func showPicture() {
//           }
//}
