//
//  DZRecommendCategoryCell.swift
//  baisi
//
//  Created by Other on 16/2/11.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit

class DZRecommendCategoryCell: UITableViewCell {

    var category: DZRecommendCategory? {
        willSet {
            textLabel?.text = newValue?.name
        }
        
    }
    
    @IBOutlet weak var selectedIndicator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.userColor(244, green: 244, blue: 244)
        selectedIndicator.backgroundColor = UIColor.userColor(219, green: 21, blue: 26)
         // 当cell的UITableViewCellSelectionStyle为None时, cell被选中时, 内部的子控件就不会进入高亮状态.否则会出现高亮状态，会覆盖自定义的效果
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.y = 2
        textLabel?.height = contentView.height - 2 * (textLabel?.y)!
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectedIndicator.hidden = selected ? false : true
        textLabel?.textColor = selected ? selectedIndicator.backgroundColor : UIColor.userColor(78, green: 78, blue: 78)
    }
    
   }
