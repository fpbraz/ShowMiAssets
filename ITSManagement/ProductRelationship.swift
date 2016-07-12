//
//  ProductRelationship.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-11.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import Foundation

enum ProductRelationshipType:String {
    case Contains = "contains"
}

class ProductRelationship {
    var type: ProductRelationshipType?
    var productURLString: String?
    
    init(dictionaryList:[[String:AnyObject]]) {
        let firstDict = dictionaryList.first!
        type = ProductRelationshipType(rawValue:firstDict["type"] as! String)
        
        let productDict = firstDict["product"] as! [String:AnyObject]
        productURLString = productDict["href"] as? String
    }
}