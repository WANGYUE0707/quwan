//
//  DZTabBar.swift
//  baisi
//
//  Created by Other on 16/2/11.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit

class DZTabBar: UITabBar {

    var publishBtn: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundImage = UIImage(named: "tabbar-light");
        
        // 添加发布Button
        let publishBtn = UIButton(type: .Custom)
        publishBtn.setBackgroundImage(UIImage(named: "tabBar_publish_icon"), forState: .Normal)
        publishBtn.setBackgroundImage(UIImage(named: "tabBar_publish_click_icon"), forState: .Highlighted)
        publishBtn.addTarget(self, action: "publishClick", forControlEvents: .TouchUpInside)
        publishBtn.size = (publishBtn.currentBackgroundImage?.size)!
        addSubview(publishBtn)
        self.publishBtn = publishBtn
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.width
        let height = self.height
        
        publishBtn?.center = CGPoint(x: width * 0.5, y: height * 0.5)
        
        let count = self.subviews.count
        var tabBarIndex = 0
        
        for var i = 0; i < count; i++ {
            let child = self.subviews[i]
            
            if child.isKindOfClass(NSClassFromString("UITabBarButton")!) {
                child.width = self.width / 5
                child.x = child.width * CGFloat(tabBarIndex)
                tabBarIndex++
                
                if tabBarIndex == 2 {
                    tabBarIndex++
                }
            }
        }
    }
    
    
    func publishClick() {
        DZPublishView.show()
        
//        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(DZPublishViewController(), animated: false, completion: nil)
    }

}
