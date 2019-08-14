//
//  ListWebService.swift
//  PracticalTask
//
//  Created by Hitesh Mistri on 8/14/19.
//  Copyright © 2019 Taykun. All rights reserved.
//

import UIKit
import ObjectMapper

class ListWebService {
    static let shared = ListWebService()
    
    func getListofMediaService(endURL:String, success:@escaping([MediaList]) -> Void, failed:@escaping(String) -> Void) {
        if !Rechability.isConnectedToNetwork() {
            failed("Please check your internet connection")
            return
        }
    
        WebService().GetWebservice(endPoint: endURL) { (result) in
            switch result {
            case .success(let value):
                if let data = value["results"].arrayObject {
                    if let responseObject = Mapper<MediaList>().mapArray(JSONObject: data) {
                        success(responseObject)
                    }
                } else {
                    failed("Something went wrong")
                }
                break
            case .failure(let error):
                failed(error.localizedDescription)
                break
            }
        }
        
    }
    
    
}
