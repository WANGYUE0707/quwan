//
//  DZNaviViewController.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/8/28.
//  Copyright © 2015年 望月. All rights reserved.
//

import UIKit


class DZNaviViewController: UINavigationController {
    
    override class func initialize () {
        let bar = UINavigationBar.appearance()
        bar.setBackgroundImage(UIImage(named: "navigationbarBackgroundWhite"), forBarMetrics: .Default)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 重写navi推出控制器方法来设置控制器
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        
        if self.viewControllers.count > 0 {
            
            let btn = UIButton(type: UIButtonType.Custom)
            btn.setImage(UIImage(named: "navigationButtonReturn"), forState: UIControlState.Normal)
            btn.setImage(UIImage(named: "navigationButtonReturnClick"), forState: UIControlState.Highlighted)
            btn.size = CGSize(width: 70, height: 30)
            btn.contentHorizontalAlignment = .Left // 按钮内部所有的内容左对齐
            btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0) // 按钮内容左偏10
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            btn.setTitleColor(UIColor.redColor(), forState: .Highlighted)
            btn.addTarget(self, action: "back", forControlEvents: .TouchUpInside)
            
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
            
            // 推出新的控制器时隐藏bottomBar
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func back() {
        self.popViewControllerAnimated(true)
    
    }
    
//    func more() {
//        self.popToRootViewControllerAnimated(true)
//    }

}
