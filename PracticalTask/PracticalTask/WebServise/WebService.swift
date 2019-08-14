//
//  WebService.swift
//  PracticalTask
//
//  Created by Hitesh Mistri on 8/14/19.
//  Copyright © 2019 Taykun. All rights reserved.
//

import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON

let BASEURL = "https://itunes.apple.com/search?"

struct WebService {
    var request:DataRequest?
    
    func GetWebservice(endPoint:String,completion:@escaping (Result<JSON>) -> Void) {
        Alamofire.request(BASEURL + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseSwiftyJSON { (response) in
            print("",response.response?.statusCode ?? -1)
            print("URL:=\(response.request?.url?.absoluteString ?? "")")
            print("Response:=\(response.result.value ?? JSON())")
            completion(response.result)
        }
    }
   
}
