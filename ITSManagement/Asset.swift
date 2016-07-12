//
//  Asset.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-11.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import Foundation

enum AssetStatus:String {
    case Created = "Created"
}

class Asset {
    
    var id:Int?
    var urlString: String?
    var name: String?
    var description: String?
    var status: AssetStatus?
    var isCustomerVisible = false
    var isBundle = false
    var productSerialNumber: String?
    var startDate: NSDate?
    var orderDate: NSDate?
    var terminationDate: NSDate?
    var placeURLString: String?
    var productOffering: ProductOfering?
    var productSpecification: ProductSpecification?
    var productCharacteristic: ProductCharacteristic?
    var productRelationship: ProductRelationship?
    var billingAccount: BillingAccount?
    var relatedParty: RelatedParty?
    var productPrice: ProductPrice?
    var realizingServiceID: String?
    
    lazy var dateFormatter: NSDateFormatter = {
       var dateFormatter = NSDateFormatter()
        dateFormatter.calendar = NSCalendar.currentCalendar()
        dateFormatter.dateFormat = "yyyy-MM-ddThh:mm:ssZ"
        return dateFormatter
    }()
    
    init(){
        
    }
    
    init(dictionary:[String:AnyObject]) {
        id = dictionary["id"] as? Int
        urlString = dictionary["href"] as? String
        name = dictionary["name"] as? String
        description = dictionary["description"] as? String
        status = AssetStatus(rawValue: dictionary["status"] as! String)
        isCustomerVisible = NSString(string: (dictionary["isCustomerVisible"] as! String)).boolValue
        isBundle = NSString(string: (dictionary["isBundle"] as! String)).boolValue
        productSerialNumber = dictionary["productSerialNumber"] as? String
        startDate = dateFormatter.dateFromString(dictionary["startDate"] as! String)
        orderDate = dateFormatter.dateFromString(dictionary["orderDate"] as! String)
        placeURLString = dictionary["place"] as? String
        productOffering = ProductOfering(dictionary: dictionary["productOffering"] as! [String:AnyObject])
        productSpecification = ProductSpecification(dictionary: dictionary["productSpecification"] as! [String:AnyObject])
        productCharacteristic = ProductCharacteristic(dictionaryList: dictionary["productCharacteristic"] as! [[String:AnyObject]])
        productRelationship = ProductRelationship(dictionaryList: dictionary["productRelationship"] as! [[String:AnyObject]])
        billingAccount = BillingAccount(dictionaryList: dictionary["billingAccount"] as! [[String:AnyObject]])
        relatedParty = RelatedParty(dictionaryList: dictionary["relatedParty"] as! [[String:AnyObject]])
        realizingServiceID = ((dictionary["realizingService"] as! [[String:AnyObject]]).first!)["id"] as? String
        productPrice = ProductPrice(dictionaryList: dictionary["productPrice"] as! [[String:AnyObject]])
    }
    
    func parametersDescription() -> [String: AnyObject] {
        guard let name = name ,let owner = productCharacteristic?.name ,let latitude = productCharacteristic?.latitude ,let longitude = productCharacteristic?.longitude, let photos = productCharacteristic?.picturesURLs  else {
            return [String: AnyObject]()
        }
        
        let coordinatesString = "\(latitude),\(longitude)"
        
        return [
            "name":name,
            "owner":owner,
            "coordinates":coordinatesString,
            "photos":photos.joinWithSeparator(","),
        ]
    }
    
}
