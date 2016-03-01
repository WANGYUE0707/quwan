//
//  DZTopicCell.swift
//  baisi
//
//  Created by 朱颖宇 on 16/2/16.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit

class DZTopicCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var createTimeLabel: UILabel!
    @IBOutlet weak var dingButton: UIButton!
    @IBOutlet weak var caiButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var sinaVView: UIImageView!
    @IBOutlet weak var text_label: UILabel!
    @IBOutlet weak var topCmtView: UIView!
    @IBOutlet weak var topCmtContentLabel: UILabel!
    // 懒加载
    lazy var pictureView: DZTopicPictureView? = {
        let pictureView = DZTopicPictureView.pictureView()
        self.contentView.addSubview(pictureView)
        return pictureView 
    }()
    
    lazy var voiceView: DZTopicVoiceView? = {
        let voiceView = DZTopicVoiceView.voiceView()
        self.contentView.addSubview(voiceView)
        return voiceView
    }()
    
    lazy var videoView: DZTopicVideoView? = {
        let videoView = DZTopicVideoView.videoView()
        self.contentView.addSubview(videoView)
        return videoView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let bgView = UIImageView(image: UIImage(named: "mainCellBackground"))
        backgroundView = bgView
    }
    
    class func cellFromNib()-> DZTopicCell {
        return NSBundle.mainBundle().loadNibNamed("DZTopicCell", owner: nil, options: nil).last as! DZTopicCell
    }

    var topic: DZTopic? {
        willSet(topic) {
//            if let v = topic.
            debugPrint(topic!.sina_v)
            
            sinaVView.hidden = true
            
            profileImageView.kf_setImageWithURL(NSURL(string: (topic?.profile_image)!)!, placeholderImage: UIImage(named: "defaultUserIcon"))
            nameLabel.text = topic?.name
            createTimeLabel.text = topic?.create_time
            
            setupButtonTitle(dingButton, count: (topic?.ding)!, placeholder: "顶")
            setupButtonTitle(caiButton, count: (topic?.cai)!, placeholder: "踩")
            setupButtonTitle(shareButton, count: (topic?.repost)!, placeholder: "分享")
            setupButtonTitle(commentButton, count: (topic?.comment)!, placeholder: "评论")
            
            text_label.text = topic?.text
            
            if topic?.type == DZTopicType.Picture.rawValue { // 图片
                pictureView?.topic = topic
                pictureView?.frame = (topic?.pictureF)!
                voiceView?.hidden = true
                videoView?.hidden = true
                pictureView?.hidden = false
            } else if topic?.type == DZTopicType.Voice.rawValue { // 声音
                voiceView?.topic = topic
                voiceView?.frame = (topic?.voiceF)!
                voiceView?.hidden = false
                videoView?.hidden = true
                pictureView?.hidden = true
            } else if topic?.type == DZTopicType.Video.rawValue { // 视频
                videoView?.topic = topic
                videoView?.frame = (topic?.videoF)!
                voiceView?.hidden = true
                videoView?.hidden = false
                pictureView?.hidden = true
            } else if topic?.type == DZTopicType.Word.rawValue { // 文字
                voiceView?.hidden = true
                videoView?.hidden = true
                pictureView?.hidden = true
            }
            
            if let cmt = topic!.top_cmt?.first as? DZComment {
               topCmtContentLabel.text  = "\(cmt.user.username):\(cmt.content)"
                topCmtView.hidden = false
            } else {
                topCmtView.hidden = true
            }
        }
    }
    
    func setupButtonTitle(button: UIButton, count: NSNumber, var placeholder: String) {
        if Int(count) > 10000 {
            let wan = Double(count) / 10000.0
            placeholder = wan.format(f: ".1")
        } else {
            placeholder = "\(count)"
        }
        button.setTitle(placeholder, forState: .Normal)
    }
    
    // 重写frame方法,在frame设置后再重新改变frame的大小
    override var frame: CGRect {
        didSet {
//            let margin: CGFloat = 10
            var frame = self.frame
            frame.origin.x = DZTopicCellMargin
            frame.size.width -= 2 * DZTopicCellMargin
            frame.size.height -= DZTopicCellMargin
            frame.origin.y += DZTopicCellMargin
            super.frame = frame
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func more(sender: AnyObject) {
        // TODO: 过期方法
        let sheet = UIActionSheet(title: nil, delegate: nil, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "举报", "收藏")
        sheet.showInView(window!)
    }
    
}

//extension DZTopicCell {
//    func testDate(date: String?) {
//        let fmt = NSDateFormatter()
//        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        
//        let now = NSDate()
//        
//        let creat = fmt.dateFromString(date!)
//        
//        debugPrint("\(fmt.stringFromDate(now))-----\(date)----\(creat?.deltaFrom(now))")
//        
//    }
//}

