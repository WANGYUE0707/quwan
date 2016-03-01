//
//  DZVerticalButton.swift
//  baisi
//
//  Created by Other on 16/2/14.
//  Copyright © 2016年 wangyue. All rights reserved.
//

import UIKit

class DZVerticalButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        titleLabel?.textAlignment = .Center
    }

    override func awakeFromNib() {
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 调整图片
        imageView?.x = 0
        imageView?.y = 0
        imageView?.width = width
        imageView?.height = imageView!.width
        
        // 调整文字
        titleLabel?.x = 0
        titleLabel?.y = (imageView?.height)!
        titleLabel?.width = width
        titleLabel?.height = height - (titleLabel?.y)!
        
//        debugPrint("======\(imageView)------\(titleLabel)")
        
    }
    
    
}
