//
//  AnchorGroup.swift
//  zhiboTV
//
//  Created by 林聪 on 2023/2/20.
//  Copyright © 2023 Lynn. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    var room_list: [[NSString : NSObject]]?
    
    var tag_name: NSString = ""
    
    var small_icon_url: NSString = ""
    
    lazy var anchos: [AnchorModel] = [AnchorModel]()
    
    override init() {
        
    }
    
    init(dic: [NSString : NSObject]) {
        super.init()
        
        self.tag_name = dic["tag_name"] as! NSString
        self.small_icon_url = dic["small_icon_url"] as! NSString
        
        
        setValuesForKeys(dic as [String : Any])
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArr = value as? [[NSString : NSObject]] {
                for dic in dataArr {
                    anchos.append(AnchorModel(dic: dic))
                }
            }
        }
    }
}
