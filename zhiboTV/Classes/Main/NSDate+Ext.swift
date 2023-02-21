//
//  NSDate+Ext.swift
//  zhiboTV
//
//  Created by 林聪 on 2023/2/20.
//  Copyright © 2023 Lynn. All rights reserved.
//

import UIKit

extension NSDate {
    class func getCurrentTime() -> NSString{
        let currentTime = Int(NSDate().timeIntervalSince1970)
        return "\(currentTime)" as NSString
    }
}
