//
//  ProductCharacteristic.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-11.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import Foundation

class ProductCharacteristic {
//    var name:String?
//    var value:String?
    var picturesURLs:[String]?
    var latitude:Double?
    var longitude:Double?
	var owner: String?
    
    init(){
        
    }
    
    init(dictionaryList:[[String:AnyObject]]) {
		
		for dictionary in dictionaryList {
			
			guard
				let name = dictionary["name"] as? String,
				let value = dictionary["value"] as? String else { continue }
			
			switch name {
			
			case "owner":
				owner = value
				
			case "pictures":
				picturesURLs = value.componentsSeparatedByString(",")
				
			case "coordinates":
				let components = value.componentsSeparatedByString(",")
				latitude  = (components[0] as NSString!).doubleValue
				longitude = (components[1] as NSString!).doubleValue
				
			default:
				continue
			}
		}
    }
}
