//
//  ProductSpecification.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-11.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import Foundation

class ProductSpecification {
    var id:String?
    
    init(dictionary:[String:AnyObject]) {
        id = dictionary["id"] as? String
    }
}