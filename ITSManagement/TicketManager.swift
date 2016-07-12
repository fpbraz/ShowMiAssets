//
//  TicketManager.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-12.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import Foundation
import Alamofire

class TicketManager {
    
    func requestTicketCreation(ticket: Ticket, completion: (response: NSHTTPURLResponse?)->()) {
        
        Alamofire.request(.POST, "http://marsupial.mybluemix.net/ticket",
            parameters: ticket.parametersDescription(), encoding: .JSON, headers: ["Content-Type": "application/json", "Accept": "application/json"])
            .response { (request, response, data, error) in
                do {
                    try print(NSJSONSerialization.JSONObjectWithData((request?.HTTPBody)!, options: .AllowFragments))
                } catch {
                    
                }
                
                print(error?.localizedDescription)
                completion(response: response)
        }
    }
}