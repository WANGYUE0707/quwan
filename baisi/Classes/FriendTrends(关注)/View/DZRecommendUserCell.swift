//
//  DZRecommendUserCell.swift
//  baisi
//
//  Created by Other on 16/2/11.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit
import Kingfisher

class DZRecommendUserCell: UITableViewCell {

    var user: DZRecommendUser? {
        willSet(user) {
            screenNameLabel.text = user?.screen_name
            
            if Int((user?.fans_count)!) < 10000 {
                fansCountLabel.text = "\(user?.fans_count)" + "人关注"
            } else {
                let wan = Double((user?.fans_count)!) / 10000.0
                fansCountLabel.text = wan.format(f: ".1") + "万人关注"
            }
            headerImageView.kf_setImageWithURL(NSURL(string: (user?.header)!)!, placeholderImage: UIImage(named: "defaultUserIcon"))
        }
    }
    
    @IBOutlet weak var fansCountLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
 
   
}
