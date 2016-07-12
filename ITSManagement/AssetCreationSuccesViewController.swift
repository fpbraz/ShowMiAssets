//
//  AssetCreationSuccesViewController.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-12.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import UIKit
import QRCode

class AssetCreationSuccesViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var url: String?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let url = url {
            let url = NSURL(string: url)
            let qrCode = QRCode(url!)
            imageView.image = qrCode?.image
        }        
    }
    
    @IBAction func backHomeAction(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}