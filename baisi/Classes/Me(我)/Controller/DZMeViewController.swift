//
//  DZMeViewController.swift
//  baisi
//
//  Created by Other on 16/2/11.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit

class DZMeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "我的"
        let settingItem = UIBarButtonItem.item("settingClick", target: self, imageName: "mine-setting-icon", highlightedImageName: "mine-setting-icon-click")
        
        let moonItem = UIBarButtonItem.item("moonClick", target: self, imageName: "mine-moon-icon", highlightedImageName: "mine-moon-icon-click")
        navigationItem.rightBarButtonItems = [settingItem, moonItem]
        
        view.backgroundColor = UIColor.globalColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func settingClick() {
        DZPrintFunc()
    }
    
    func moonClick() {
        DZPrintFunc()
    }

}
