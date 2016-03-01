//
//  DZViewController.swift
//  baisi
//
//  Created by 朱颖宇 on 16/2/26.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit
import pop

let DZAnimationDelay: CGFloat = 0.1
let DZSpringFactor: CGFloat = 10

typealias completionClosure = (() -> Void)
// TODO: 使用枚举值定义方法
enum PublishType: Int {
    case video = 0, picture, text, audio, review, offline
}

class DZPublishViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    // 设置不能点击
    view.userInteractionEnabled = false
        
        setupUI()
        
        }
    
    func setupUI() {
        // 数据
        let images = ["publish-video", "publish-picture", "publish-text", "publish-audio", "publish-review", "publish-offline"]
        
        let titles = ["发视频", "发图片", "发段子", "发声音", "审帖", "离线下载"]
        
        // button
        let maxCols: CGFloat = 3
        
        let buttonW: CGFloat = 72
        let buttonH = buttonW + 30
        let buttonStartY = (UIScreen.height - 2 * buttonH) * 0.5
        let buttonStartX: CGFloat = 20
        
        let margin = (UIScreen.width - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1)
        
        for i in 0..<images.count {
            let button = DZVerticalButton()
            button.titleLabel?.font = UIFont.systemFontOfSize(14)
            button.setTitle(titles[i], forState: .Normal)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.setImage(UIImage(named: images[i]), forState: .Normal)
            button.addTarget(self, action: "buttonClick:", forControlEvents: .TouchUpInside)
            view.addSubview(button)
            button.tag = i
            // 设置frame
            //            button.width = buttonW
            //            button.height = buttonH
            let row = i / Int(maxCols)
            let col = i % Int(maxCols)
            let buttonX = buttonStartX + CGFloat(col) * (margin + buttonW)
            let buttonEndY = buttonStartY + CGFloat(row) * buttonH
            let buttonBeginY = buttonEndY - UIScreen.height
            //            button.x = buttonStartX + CGFloat(col) * (margin + buttonW)
            //            button.y = buttonStartY + CGFloat(row) * buttonH
            let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
            
            animation.fromValue = NSValue(CGRect: CGRect(x: buttonX, y: buttonBeginY, width: buttonW, height: buttonH))
            animation.toValue = NSValue(CGRect: CGRect(x: buttonX, y: buttonEndY, width: buttonW, height: buttonH))
            
            animation.springBounciness = DZSpringFactor
            animation.springSpeed = DZSpringFactor
            animation.beginTime = CACurrentMediaTime() + Double(DZAnimationDelay * CGFloat(i))
            button.pop_addAnimation(animation, forKey: nil)
        }
        
        
        let sloganView = UIImageView(image: UIImage(named: "app_slogan"))
        view.addSubview(sloganView)
        let centerX = UIScreen.width * 0.5
        let centerEndY = UIScreen.height * 0.2
        let centerBeginY = centerEndY - UIScreen.height
//        let sloganViewEndY = UIScreen.height * 0.2
//        sloganView.centerX = UIScreen.width * 0.5
        let animation = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        animation.fromValue = NSValue(CGPoint: CGPoint(x: centerX, y: centerBeginY))
        animation.toValue = NSValue(CGPoint: CGPoint(x: centerX, y: centerEndY))
        animation.beginTime = CACurrentMediaTime() + Double(CGFloat(images.count) * DZAnimationDelay)
        // 反弹
        animation.springBounciness = DZSpringFactor
        // 速度
        animation.springSpeed = DZSpringFactor
        
        // 添加动画
        animation.completionBlock = ({ pop, bool in
                self.view.userInteractionEnabled = true
            })
        sloganView.pop_addAnimation(animation, forKey: nil)
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        cancelPublish(nil)
    }
    
    func buttonClick(button: UIButton) {
        cancelPublish { () -> Void in
            if button.tag == PublishType.video.rawValue {
                    debugPrint("视频")
                } else if button.tag == PublishType.picture.rawValue {
                    debugPrint("图片")
                }
            }
        }
    
    func cancelPublish(completion: completionClosure?) {
        view.userInteractionEnabled = false
        
        for i in 2..<view.subviews.count {
            let subView = view.subviews[i]
            let animation = POPBasicAnimation(propertyNamed: kPOPViewCenter)
            let centerY = subView.centerY + UIScreen.height
            
            animation.toValue = NSValue(CGPoint: CGPoint(x: subView.centerX, y: centerY))
            animation.beginTime = CACurrentMediaTime() + Double(i - 2) * Double(DZAnimationDelay)
            subView.pop_addAnimation(animation, forKey: nil)
            
            if i == view.subviews.count - 1 {
                animation.completionBlock = { pop, bool in
                    self.dismissViewControllerAnimated(false, completion: nil)
                    if completion != nil {
                        completion!()
                    }
                }
            }
        }
    }
    
    // 点击view退出
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        cancelPublish(nil)
    }
}
