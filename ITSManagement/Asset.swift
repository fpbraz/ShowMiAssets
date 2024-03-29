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
        if let startString = dictionary["startDate"] as? String{
            startDate = dateFormatter.dateFromString(startString)
        }
        if let orderString = dictionary["orderDate"] as? String{
            orderDate = dateFormatter.dateFromString(orderString)
        }
//        orderDate = dateFormatter.dateFromString(dictionary["orderDate"] as! String)
        placeURLString = dictionary["place"] as? String
        productOffering = ProductOfering(dictionary: dictionary["productOffering"] as! [String:AnyObject])
        
        if let specification = dictionary["productSpecification"] as? [String:AnyObject] {
           productSpecification = ProductSpecification(dictionary: specification)
        }
        
        productCharacteristic = ProductCharacteristic(dictionaryList: dictionary["productCharacteristic"] as! [[String:AnyObject]])
        
        if let relationship = dictionary["productRelationship"] as? [[String:AnyObject]] {
            if relationship.count > 0 {
                productRelationship = ProductRelationship(dictionaryList: relationship)
            }
        }
        
        if let billingAccount = dictionary["billingAccount"] as? [[String:AnyObject]] {
            if billingAccount.count > 0 {
                self.billingAccount = BillingAccount(dictionaryList: billingAccount)
            }
        }
        
        if let relatedParty = dictionary["relatedParty"] as? [[String:AnyObject]] {
            if relatedParty.count > 0 {
                self.relatedParty = RelatedParty(dictionaryList: relatedParty)
            }
        }
        
//        realizingServiceID = ((dictionary["realizingService"] as! [[String:AnyObject]]).first!)["id"] as? String
        
        if let productPrice = dictionary["productPrice"] as? [[String:AnyObject]] {
            if productPrice.count > 0 {
                self.productPrice = ProductPrice(dictionaryList: productPrice)
            }
        }
    }
    
    func parametersDescription() -> [String: AnyObject] {
        guard let name = name ,let owner = productCharacteristic?.owner ,let latitude = productCharacteristic?.latitude ,let longitude = productCharacteristic?.longitude, let photos = productCharacteristic?.picturesURLs  else {
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
