//
//  MenuBar.swift
//  MyYoutube
//
//  Created by xszhao on 2016-08-22.
//  Copyright © 2016 xszhao. All rights reserved.
//

import UIKit
//How to create a custom UIView

class MenuBar: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.blueColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
