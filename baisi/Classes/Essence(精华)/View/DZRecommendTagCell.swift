//
//  DZRecommendTagCell.swift
//  baisi
//
//  Created by Other on 16/2/15.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit

class DZRecommendTagCell: UITableViewCell {

    @IBOutlet weak var imageListImageView: UIImageView!
    
    @IBOutlet weak var themeNameLabel: UILabel!
    
    @IBOutlet weak var subNumberLabel: UILabel!
    
    var recommendTag: DZRecommendTag? {
        willSet(recommendTag) {
            imageListImageView.kf_setImageWithURL(NSURL(string: (recommendTag!.image_list)!)!, placeholderImage: UIImage(named: "defaultUserIcon"))
            
            themeNameLabel.text = recommendTag?.theme_name
            
            if Int((recommendTag?.sub_number)!) < 10000 {
                let wan = Double((recommendTag?.sub_number)!) / 10000.0
                subNumberLabel.text = "\(wan.format(f: ".1")))" + "万人订阅"
            } else {
                subNumberLabel.text = "\(recommendTag?.sub_number)" + "人订阅"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
