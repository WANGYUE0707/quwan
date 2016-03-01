//
//  DZEssenceViewController.swift
//  baisi
//
//  Created by Other on 16/2/11.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit
import AVFoundation

class DZEssenceViewController: UIViewController, UIScrollViewDelegate {

    var indicatorView: UIView?
    var selectedButton: UIButton?
    var titlesView: UIView?
    var contentView: UIScrollView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavi()
        
        setupChildVCes()
        
        setupTitlesView()
        
        setupContentView()
        
    }
    
    func setupChildVCes() {
        let video = DZTopicViewController()
        video.title = "视频"
        video.topicType = .Video
        addChildViewController(video)
        
        let voice = DZTopicViewController()
        voice.title = "声音"
        voice.topicType = .Voice
        addChildViewController(voice)
        
        let picture = DZTopicViewController()
        picture.title = "图片"
        picture.topicType = .Picture
        addChildViewController(picture)
        
        let word = DZTopicViewController()
        word.title = "段子"
        word.topicType = .Word
        addChildViewController(word)
        
        let all = DZTopicViewController()
        all.title = "全部"
        all.topicType = .All
        addChildViewController(all)
        
    }
    
    func setupTitlesView() {
        let titlesView = UIView()
        titlesView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
        titlesView.width = view.width
        titlesView.height = DZTitlesViewH
        titlesView.y = DZTitlesViewY
        view.addSubview(titlesView)
        
        // 底部红色指示器
        let indicatorView = UIView()
        indicatorView.backgroundColor = UIColor.redColor()
        indicatorView.height = 2
        indicatorView.tag = -1
        indicatorView.y = titlesView.height - indicatorView.height
        self.indicatorView = indicatorView
        
        // 内部子标签
//        let titles = ["全部", "视频", "声音", "图片", "段子"]
        let width = titlesView.width / CGFloat(childViewControllers.count)
        let height = titlesView.height
        for i in 0..<childViewControllers.count {
            let button = UIButton()
            button.tag = i
            button.height = height
            button.width = width
            button.x = CGFloat(i) * width
            button.setTitle(childViewControllers[i].title, forState: .Normal)
            button.setTitleColor(UIColor.grayColor(), forState: .Normal)
            button.setTitleColor(UIColor.redColor(), forState: .Disabled)
            button.titleLabel?.font = UIFont.systemFontOfSize(14)
            button.addTarget(self, action: "titleClick:", forControlEvents: .TouchUpInside)
            titlesView.addSubview(button)
            self.titlesView = titlesView
            // 默认选中第1个按钮
            if i == 0 {
                button.enabled = false
                selectedButton = button
                // 按钮内部Label根据文字计算尺寸
                button.titleLabel?.sizeToFit()
                
                indicatorView.width = button.width
                indicatorView.centerX = button.centerX
            }
        }
        
        titlesView.addSubview(indicatorView)

    }
    
    func setupNavi() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "MainTitle"))
        navigationItem.leftBarButtonItem = UIBarButtonItem.item("tagClick", target: self, imageName: "MainTagSubIcon", highlightedImageName: "MainTagSubIcon")
        view.backgroundColor = UIColor.globalColor()

    }

    func titleClick(sender: UIButton) {
        
        selectedButton?.enabled = true
        sender.enabled = false
        selectedButton = sender
        UIView.animateWithDuration(0.25) { () -> Void in
            self.indicatorView?.width = (sender.titleLabel?.width)!
            self.indicatorView?.centerX = sender.centerX
        }
        
        // 滚动
        var offset = contentView?.contentOffset
        offset?.x = CGFloat(sender.tag) * (contentView?.width)!
        contentView?.setContentOffset(offset!, animated: true)
    }
    
    func setupContentView() {
        automaticallyAdjustsScrollViewInsets = false
        
        let contentView = UIScrollView()
        contentView.frame = view.bounds
        contentView.delegate = self
        contentView.pagingEnabled = true
        view.insertSubview(contentView, atIndex: 0)
        contentView.contentSize = CGSize(width: contentView.width * CGFloat(childViewControllers.count), height: 0)
        debugPrint(contentView.contentSize)
        self.contentView = contentView
        scrollViewDidEndScrollingAnimation(contentView)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        let vc = childViewControllers[index]
        vc.view.x = scrollView.contentOffset.x
        vc.view.y = 0 // 设置控制器View的y是0， 默认是20
        vc.view.height = scrollView.height // 设置控制器的view的height 为屏幕的高(默认比控制器少20)
//        let bottom = tabBarController?.tabBar.height
//        let top = CGRectGetMaxY((titlesView?.frame)!)
//        vc.tableView.contentInset = UIEdgeInsets(top: top, left: 0, bottom: bottom!, right: 0)
        // 设置滚动条内边距
//        vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset
        scrollView.addSubview(vc.view)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
      
        scrollViewDidEndScrollingAnimation(scrollView)
        
        // 点击按钮
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        debugPrint(titlesView?.subviews[index])
        titleClick(titlesView?.subviews[index] as! UIButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tagClick() {
       DZPrintFunc()
        
        navigationController?.pushViewController(DZRecommendTagsViewController(), animated: true)
//        presentViewController(DZQRCodeViewController(), animated: true, completion: nil)
        
    }
    
}
