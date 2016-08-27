//
//  Video.swift
//  MyYoutube
//
//  Created by xszhao on 2016-08-24.
//  Copyright © 2016 xszhao. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?
    
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}