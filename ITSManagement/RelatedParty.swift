//
//  RelatedParty.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-11.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import Foundation

enum RelatedPartyRole:String {
    case Partner = "partner"
}

class RelatedParty {
    var id: Int?
    var role: RelatedPartyRole?
    var urlString: String?
    
    init(dictionaryList:[[String:AnyObject]]) {
        let firstDict = dictionaryList.first!
        id = firstDict["id"] as? Int
        role = RelatedPartyRole(rawValue:firstDict["role"] as! String)
        urlString = firstDict["href"] as? String
    }

}