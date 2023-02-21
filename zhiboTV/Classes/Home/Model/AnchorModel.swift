//
//  AnchorModel.swift
//  zhiboTV
//
//  Created by 林聪 on 2023/2/20.
//  Copyright © 2023 Lynn. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    // 房间id
    @objc var room_id: NSString = ""
    // 房间图片
    @objc var vertical_src: NSString = ""
    // 是否手机登陆 0:电脑登陆 1: 手机登陆
    @objc var isVertical: Int = 0
    // 房间名称
    @objc var room_name: NSString = ""
    // 主播名称
    @objc var nickname: NSString = ""
    // 在线人数
    @objc var online: Int = 0
    // 城市
    @objc var anchor_city: NSString = ""
    
    init(dic: [NSString : NSObject]) {
        super.init()
        
        setValuesForKeys(dic as [String : Any])
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }

}
