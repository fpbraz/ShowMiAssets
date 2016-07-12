
//
//  ImageRecon.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-12.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import Foundation

class ImageRecon {
    
    var tags:[String]
    
    init(dictionary:[String:AnyObject]) {
        let imagesDict = (dictionary["images"] as! [[String:AnyObject]]).first!
        
        if let classifiersDict = imagesDict["classifiers"] as? [String:AnyObject] {
            if let classesDict = classifiersDict["classes"] as? [[String:AnyObject]] {
                var jsonTags = [String]()
                
                for dictionary in classesDict {
                    jsonTags.append(dictionary["class"] as! String)
                }
                
                tags = jsonTags
            } else {
                tags = [String]()
            }
            
        } else {
            tags = [String]()
        }
    }
    
}