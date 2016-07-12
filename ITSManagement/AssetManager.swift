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
        Alamofire.request(.GET, "http://marsupial.mybluemix.net/asset?id=48", parameters: nil)
            .responseJSON { response in                
                
                if let response = response.result.value {
                    let asset = Asset(dictionary: response as! [String:AnyObject])
                    completion(result: [asset])
                }
        }
    }
    
    func requestAssetCreation(asset: Asset, completion: (response: NSHTTPURLResponse?)->()) {
        Alamofire.request(.POST, "http://marsupial.mybluemix.net/asset",
            parameters: asset.parametersDescription(), encoding: .JSON, headers: ["Content-Type": "application/json", "Accept": "application/json"])
            .response { (request, response, data, error) in
                do {
                    try print(NSJSONSerialization.JSONObjectWithData((request?.HTTPBody)!, options: .AllowFragments))
                } catch {
                    
                }
                
                print(error?.localizedDescription)
                completion(response: response)
        }
    }
}