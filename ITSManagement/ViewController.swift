//
//  ViewController.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-11.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import UIKit
import QRCodeReader
import AVFoundation
import MapKit

class ViewController: UIViewController, QRCodeReaderViewControllerDelegate {

    lazy var readerViewController = QRCodeReaderViewController(metadataObjectTypes: [AVMetadataObjectTypeQRCode])
    
    @IBAction func searchButtonAction(sender: AnyObject) {
        readerViewController.delegate = self
        
        readerViewController.completionBlock = { (result: QRCodeReaderResult?) in
            print(result)
        }
        
        readerViewController.modalPresentationStyle = .FormSheet
        presentViewController(readerViewController, animated: true, completion: nil)
    }

    // QRReader Delegate
    func reader(reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func readerDidCancel(reader: QRCodeReaderViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.performSegueWithIdentifier("scanToReportSegue", sender: nil)
    }
    
}

