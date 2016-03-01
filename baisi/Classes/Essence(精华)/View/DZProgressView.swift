//
//  DZProgressView.swift
//  baisi
//
//  Created by 朱颖宇 on 16/2/19.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit

class DZProgressView: DALabeledCircularProgressView {

    override func awakeFromNib() {
        roundedCorners = 2
        progressLabel.textColor = UIColor.whiteColor()
    }
    
    override func setProgress(progress: CGFloat, animated: Bool) {
        super.setProgress(progress, animated: animated)
        let text = Double(progress * 100).format(f: ".1") + "%"
        progressLabel.text = text.stringByReplacingOccurrencesOfString("-", withString: "")
    }
}
