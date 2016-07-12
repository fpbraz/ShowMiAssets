//
//  ProductCharacteristic.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-11.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import Foundation

class ProductCharacteristic {
    var name:String?
    var value:String?
    var picturesURLs:[String]?
    var latitude:Double?
    var longitude:Double?
    
    init(){
        
    }
    
    init(dictionaryList:[[String:AnyObject]]) {
       let firstDict = dictionaryList.first!
        name = firstDict["name"] as? String
        value = firstDict["value"] as? String
        
        let picDicts = dictionaryList[1]
        picturesURLs = getPictureURLsFromDictionary(picDicts)
        
        let coordinateDicts = dictionaryList[2]
        let coordinateString = coordinateDicts["value"] as? String
        let components = coordinateString?.componentsSeparatedByString(",")
        latitude = (components![0] as NSString!).doubleValue
        longitude = (components![1] as NSString!).doubleValue
    }

    func getPictureURLsFromDictionary(dictionary: [String:AnyObject]) -> [String] {
        let urlsStrings = dictionary["value"] as! String
        return urlsStrings.componentsSeparatedByString(",")
    }
}
