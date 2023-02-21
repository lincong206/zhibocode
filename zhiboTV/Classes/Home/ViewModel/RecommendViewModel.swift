//
//  RecommendViewModel.swift
//  zhiboTV
//
//  Created by 林聪 on 2023/2/20.
//  Copyright © 2023 Lynn. All rights reserved.
//

import UIKit

class RecommendViewModel {
    
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    
    private lazy var bigDataGruop: AnchorGroup = AnchorGroup()
    private lazy var prettyGruop: AnchorGroup = AnchorGroup()
}

extension RecommendViewModel {
    func requestData(finishCallBack: @escaping () -> ()) {
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
        let dGruop = DispatchGroup()
        
        // 1 请求第一部分 推荐数据
        //http://capi.douyucdn.cn/api/v1/getBigDataRoom?time=1676880105
        dGruop.enter()
        NetWorkTools.requstData(url: "http://capi.douyucdn.cn/api/v1/getBigDataRoom", method: .GET, parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
            guard let resultDic = result as? [NSString : NSObject] else { return }
            
            guard let dataArray = resultDic["data"] as? [[NSString : NSObject]] else { return }
            
            self.bigDataGruop.tag_name = "热门"
            self.bigDataGruop.small_icon_url = ""
            
            for dic in dataArray {
                let anchor = AnchorModel(dic: dic)
                self.bigDataGruop.anchos.append(anchor)
            }
            dGruop.leave()
        }
        
        // 2 请求第二部分 颜值数据
//http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1676880105
        dGruop.enter()
        NetWorkTools.requstData(url: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", method: .GET, parameters: parameters) { (result) in
            guard let resultDic = result as? [NSString : NSObject] else { return }
            
            guard let dataArray = resultDic["data"] as? [[NSString : NSObject]] else { return }
            
            self.prettyGruop.tag_name = "颜值"
            self.prettyGruop.small_icon_url = ""
            
            for dic in dataArray {
                let anchor = AnchorModel(dic: dic)
                self.prettyGruop.anchos.append(anchor)
            }
            dGruop.leave()
        }
        
        // 3 请求后面部分 游戏数据
//http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1676880105
        dGruop.enter()
        NetWorkTools.requstData(url: "http://capi.douyucdn.cn/api/v1/getHotCate", method: .GET, parameters: parameters) { (result) in
            guard let resultDic = result as? [NSString : NSObject] else { return }
            
            guard let dataArray = resultDic["data"] as? [[NSString : NSObject]] else { return }
            
            for dic in dataArray {
                let group = AnchorGroup(dic: dic)
                self.anchorGroups.append(group)
            }
            dGruop.leave()
        }
        
        dGruop.notify(queue: .main) {
            self.anchorGroups.insert(self.prettyGruop, at: 0)
            self.anchorGroups.insert(self.bigDataGruop, at: 0)
            
            finishCallBack()
        }
    }
}
