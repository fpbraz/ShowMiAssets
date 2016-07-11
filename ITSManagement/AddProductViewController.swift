//
//  AddProductViewController.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-11.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import UIKit
import QRCode

class AddProductViewController: UIViewController {
 
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let url = NSURL(string: "http://schuch.me")
        let qrCode = QRCode(url!)
        imageView.image = qrCode?.image
    }
}