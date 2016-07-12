//
//  ImageReconManager.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-12.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import Foundation
import Alamofire

class ImageReconManager {
 
    func fetchImageReconForImage(url: String, completion: (imageRecon: ImageRecon?)->()) {
        Alamofire.request(.GET, "http://marsupial.mybluemix.net/photo_tags",
            parameters: ["url":url])
            .responseJSON { response in
                if let response = response.result.value as? [String:AnyObject] {
                    let result = ImageRecon(dictionary: response)
                    
                    completion(imageRecon: result)
                }
        }

    }
    
}