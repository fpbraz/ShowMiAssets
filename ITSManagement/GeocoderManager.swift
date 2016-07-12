//
//  GeocoderManager.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-12.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire

class GeocoderManager {
    
    func fetchAddress(location: CLLocationCoordinate2D, completion:(address: String?) ->()) {
        Alamofire.request(.GET, "http://apps.gov.bc.ca/pub/geocoder/sites/nearest.json?outputSRS=4326&locationDescriptor=any&setBack=0",
            parameters: ["point":"\(location.longitude), \(location.latitude)"])
            .responseJSON { response in
                if let response = response.result.value as? [String:AnyObject] {
                    let properties = response["properties"] as! [String:AnyObject]
                    
                    completion(address: properties["fullAddress"] as? String)
                }
        }
    }
    
}