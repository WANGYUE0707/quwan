//
//  DZTopicVideoView.swift
//  baisi
//
//  Created by 朱颖宇 on 16/2/26.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit

class DZTopicVideoView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var videolengthLabel: UILabel!
    @IBOutlet weak var playcountlabel: UILabel!
    
    
    var topic: DZTopic? {
        didSet {
            imageView.kf_setImageWithURL(NSURL(string: (topic?.large_image)!)!)
            
            playcountlabel.text = "\((topic?.playcount)!)播放"
            // 时长
            let minute = Double(Int((topic?.videotime)!) / 60).format(f: "02.0")
            let second = Double(Int((topic?.videotime)!) % 60).format(f: "02.0")
            videolengthLabel.text = "\(minute):\(second)"
        }
    }
    
    class func videoView() -> DZTopicVideoView {
        return NSBundle.mainBundle().loadNibNamed("DZTopicVideoView", owner: nil, options: nil).last as! DZTopicVideoView
    }
    
    
    override func awakeFromNib() {
        autoresizingMask = .None
        
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "imageTap"))
    }
    
    func imageTap() {
        let showVC = DZShowPictureViewController()
        showVC.topic = self.topic
        DZKeyWindow!.rootViewController?.presentViewController(showVC, animated: true, completion: nil)
    }
    
}
