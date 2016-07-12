//
//  Ticket.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-12.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import Foundation
import CoreLocation

class Ticket {
    var issue: String?
    var issue_type: String?
    var assetID: String?
    var photo: String?
    var coordinates: CLLocationCoordinate2D?

    
    func parametersDescription() -> [String: AnyObject] {
        guard let issue = issue ,let issue_type = issue_type ,let assetID = assetID ,let photo = photo ,let coordinates = coordinates else {
            return [String: AnyObject]()
        }
        
        let coordinatesString = "\(coordinates.latitude),\(coordinates.longitude)"
        
        return [
            "issue":issue,
            "issue_type":issue_type,
            "assetID":assetID,
            "photo":photo,
            "coordinates":coordinatesString
        ]
    }
}