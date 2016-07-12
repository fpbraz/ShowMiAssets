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
        title = "Asset"
        
        if let asset = asset {
            let URL = NSURL(string: (asset.productCharacteristic?.picturesURLs?.first!)!)!
            
            imageView.af_setImageWithURL(URL)
            
            nameLabel.text = asset.name
            ownerLabel.text = asset.productCharacteristic?.name
            
            let center = CLLocationCoordinate2DMake(asset.productCharacteristic!.latitude!, asset.productCharacteristic!.longitude!)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: center, span: span)
            
            mapView.region = region
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = center
            mapView.addAnnotation(annotation)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "assetDetailToReportSegue" {
            let destinationVC = segue.destinationViewController as! ReportViewController
            destinationVC.asset = self.asset!

        }
    }
}