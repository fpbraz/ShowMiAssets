//
//  Price.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-11.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import Foundation

class Price {
    var amount: Double?
    var currency: String?

    init(dictionary:[String:AnyObject]) {
        amount = dictionary["amount"] as? Double
        currency = dictionary["currency"] as? String
    }
}