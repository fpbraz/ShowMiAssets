//
//  ProductPrice.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-11.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import Foundation

enum PriceType:String {
    case Recurring = "recurring"
}

enum RecurringChargePeriod:String {
    case Monthly = "monthly"
}

class ProductPrice {
    
    var name: String?
    var description: String?
    var priceType: PriceType?
    var recurringChargePeriod:RecurringChargePeriod?
    var unitOfMeasure:String?
    var productSerialNumber: String?
    var price: Price?
    var startValidDate: NSDate?
    var endValidDate: NSDate?
    
    lazy var dateFormatter: NSDateFormatter = {
        var dateFormatter = NSDateFormatter()
        dateFormatter.calendar = NSCalendar.currentCalendar()
        dateFormatter.dateFormat = "yyyy-MM-ddThh:mm:ssZ"
        return dateFormatter
    }()
    
    init(dictionaryList:[[String:AnyObject]]) {
        let firstDict = dictionaryList.first!
        name = firstDict["name"] as? String
        description = firstDict["description"] as? String
        priceType = PriceType(rawValue:firstDict["priceType"] as! String)
        recurringChargePeriod = RecurringChargePeriod(rawValue:firstDict["recurringChargePeriod"] as! String)
        unitOfMeasure = firstDict["unitOfMeasure"] as? String
        price = Price(dictionary: firstDict["price"] as! [String: AnyObject])
        
        let dateDict = firstDict["validFor"] as! [String: AnyObject]
        startValidDate = dateFormatter.dateFromString(dateDict["startDateTime"] as! String)
        endValidDate = dateFormatter.dateFromString(dateDict["endDateTime"] as! String)
        
    }
}