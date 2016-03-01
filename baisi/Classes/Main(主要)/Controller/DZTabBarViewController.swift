//
//  DZTabBarViewController.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/8/28.
//  Copyright © 2015年 望月. All rights reserved.
//

import UIKit

class DZTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 精华
        addChildViewController(DZEssenceViewController(), title: "精华", imageName: "tabBar_essence_icon", selectedImageName: "tabBar_essence_click_icon")
        
        // 新帖
        addChildViewController(DZNewViewController(), title: "新帖", imageName: "tabBar_new_icon", selectedImageName: "tabBar_new_click_icon")
        
        // 关注
        addChildViewController(DZFriendTrendsViewController(), title: "关注", imageName: "tabBar_friendTrends_icon", selectedImageName: "tabBar_friendTrends_click_icon")
        
        // 我
        addChildViewController(DZMeViewController(), title: "我", imageName: "tabBar_me_icon", selectedImageName: "tabBar_me_click_icon")
        
        let tabBar = DZTabBar()
//        tabBar.clickDelegate = self
        setValue(tabBar, forKeyPath: "tabBar")
                
    }
    
    /**
    添加子控制器
    
    :param: child             子控制器
    :param: title             标题
    :param: imageName         图片
    :param: selectedImageName 选中图片
    */
    func addChildViewController(child: UIViewController, title: String, imageName: String, selectedImageName: String) {
        
        child.title = title
        child.tabBarItem.image = UIImage(named: imageName)
        child.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        // 设置正常状态字体
        var textAtts = [String : AnyObject]()
        textAtts[NSForegroundColorAttributeName] = UIColor(red: (123/255.0), green: (123/255.0), blue: (123/255.0), alpha: 1)
        child.tabBarItem.setTitleTextAttributes(textAtts, forState: UIControlState.Normal)
        
//        // 设置选中状态下的字体
//        var selectTextAtts = [String : AnyObject]()
//        selectTextAtts[NSForegroundColorAttributeName] = UIColor.orangeColor()
//        child.tabBarItem.setTitleTextAttributes(selectTextAtts, forState: UIControlState.Selected)
        
        let navi = DZNaviViewController(rootViewController: child)
//
        self.addChildViewController(navi)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func tabBar(tabBar: DZTabBar) {
//        let compose = UIViewController()
//        compose.view.backgroundColor = UIColor.redColor()
//        let navi = UINavigationController(rootViewController: compose)
//        self.presentViewController(navi, animated: true, completion: nil)
//        
//    }
    
    
    
}
