//
//  BillingAccount.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-11.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import Foundation

class BillingAccount {
 
    var id:Int?
    var name: String?
//    "billingAccount":[
//    {
//    "id":"http://server:port/billingApi/billingAccount/678",
//    "name":"account name"
//    }
    
    init(dictionaryList:[[String:AnyObject]]) {
        let firstDict = dictionaryList.first!
        id = firstDict["id"] as? Int
        name = firstDict["name"] as? String
    }
}