//
//  NetWorkTools.swift
//  zhiboTV
//
//  Created by 林聪 on 2023/2/20.
//  Copyright © 2023 Lynn. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetWorkTools: NSObject {
    
    class func requstData(url: String, method: MethodType, parameters: [String : NSString]? = nil, resultCallBack: @escaping (_ result: AnyObject) -> ()) {
        
        let method = method == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error as Any)
                return
            }
            resultCallBack(result as AnyObject)
        }
    }
}
