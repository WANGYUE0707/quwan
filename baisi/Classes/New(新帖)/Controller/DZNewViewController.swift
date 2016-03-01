//
//  DZNewViewController.swift
//  baisi
//
//  Created by Other on 16/2/11.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit

class DZNewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = UIImageView(image: UIImage(named: "MainTitle"))
        navigationItem.leftBarButtonItem = UIBarButtonItem.item("tagClick", target: self, imageName: "MainTagSubIcon", highlightedImageName: "MainTagSubIcon")
        view.backgroundColor = UIColor.globalColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tagClick() {
        debugPrint("tagClick")
    }

}
