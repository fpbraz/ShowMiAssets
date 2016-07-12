//
//  AssetManager.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-11.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import Foundation
import Alamofire

class AssetManager {
    
    func fetchAssets(completion: (result:[Asset]) -> ()) {
        Alamofire.request(.GET, "http://marsupial.mybluemix.net/asset?id=16", parameters: nil)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let response = response.result.value {
                    let asset = Asset(dictionary: response as! [String:AnyObject])
                    completion(result: [asset])
                }
        }
    }
}