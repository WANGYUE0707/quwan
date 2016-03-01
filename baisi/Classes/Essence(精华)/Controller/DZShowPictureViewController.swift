//
//  DZShowPictureViewController.swift
//  baisi
//
//  Created by 朱颖宇 on 16/2/19.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit
import SVProgressHUD

class DZShowPictureViewController: UIViewController {

    @IBOutlet weak var progressView: DZProgressView!
    @IBOutlet weak var scrollView: UIScrollView!
    var imageView: UIImageView?
    var topic: DZTopic?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let screenH = UIScreen.height
        let screenW = UIScreen.width
        
        let imageView = UIImageView()
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "back:"))
        
        scrollView.addSubview(imageView)
        self.imageView = imageView
        
        // 图片尺寸
        let pictureW = screenW
        let pictureH = pictureW * CGFloat((topic?.height)!) /  CGFloat((topic?.width)!)
        
        
        
        if pictureH > screenH { // 图片过大
            imageView.frame = CGRect(x: 0, y: 0, width: pictureW, height: pictureH)
            scrollView.contentSize = CGSize(width: 0, height: pictureH);
        } else {
            imageView.size = CGSize(width: pictureW, height: pictureH)
            imageView.centerY = screenH * 0.5
        }
        
        progressView.setProgress((topic?.pictureProgress)!, animated: true)
        imageView.kf_setImageWithURL(NSURL(string: (topic?.large_image)!)!, placeholderImage: nil, optionsInfo: nil, progressBlock: { (receivedSize, totalSize) -> () in
            self.progressView.hidden = false
            let pro = CGFloat(receivedSize) / CGFloat(totalSize)
            self.progressView.setProgress(pro, animated: false)
            
            }) { (image, error, cacheType, imageURL) -> () in
                self.progressView.hidden = true
            }
        }

    
    @IBAction func back(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func save(sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum((imageView?.image)!, self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
   
    // TODO: 不符合2.1的语法?? 抛错??
    func image(image: UIImage, didFinishSavingWithError: NSError?,contextInfo: AnyObject) {
        if didFinishSavingWithError != nil {
            SVProgressHUD.showErrorWithStatus("保存失败")
        } else {
            SVProgressHUD.showSuccessWithStatus("保存成功")
            
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
