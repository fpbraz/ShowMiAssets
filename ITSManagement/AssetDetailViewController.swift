//
//  AssetDetailViewController.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-11.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import UIKit
import MapKit
import AlamofireImage

class AssetDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!    
    
    var asset: Asset?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let asset = asset {
            let URL = NSURL(string: (asset.productCharacteristic?.picturesURLs?.first!)!)!
            
            imageView.af_setImageWithURL(URL)
            
            nameLabel.text = asset.name
            ownerLabel.text = asset.productCharacteristic?.name
        }
    }
}