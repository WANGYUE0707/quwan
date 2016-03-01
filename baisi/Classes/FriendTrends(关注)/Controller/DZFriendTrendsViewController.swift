//
//  DZFriendTrendsViewController.swift
//  baisi
//
//  Created by Other on 16/2/11.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit

class DZFriendTrendsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "我的关注"
        navigationItem.leftBarButtonItem = UIBarButtonItem.item("friendsClick", target: self, imageName: "friendsRecommentIcon", highlightedImageName: "friendsRecommentIcon-click")
        view.backgroundColor = UIColor.globalColor()
        
        // 这句一定要设置
        UIApplication.sharedApplication().applicationSupportsShakeToEdit = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func friendsClick() {
        let vc = DZRecommendViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func loginRegister(sender: UIButton) {
        let login = DZLoginRegisterViewController()
        presentViewController(login, animated: true, completion: nil)
        
    }
    
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        debugPrint("开始摇动")
    }
    
    override func motionCancelled(motion: UIEventSubtype, withEvent event: UIEvent?) {
        debugPrint("取消摇动")
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if event?.subtype == .MotionShake { // 判断是否摇动结束
            debugPrint("摇动结束")
        }
    }

}
