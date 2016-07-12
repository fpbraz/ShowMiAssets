//
//  ReportViewController.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-11.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import UIKit
import CoreLocation

class ReportViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet var selectionButtons: [SelectionButton]!
    
    var userLocation: CLLocation?
    
    lazy var locationManager: CLLocationManager = {
        return CLLocationManager()
    }()
    
    lazy var imagePickerController: UIImagePickerController = {
        let imagePicker =  UIImagePickerController()
        imagePicker.sourceType = .Camera
        
        return imagePicker
    }()
    
    var assetPicture: UIImage? {
        didSet {
            userImageView.image = assetPicture
            hideCameraButton()
        }
    }
    
    func showImagePicker() {
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func photoButtonAction(sender: AnyObject) {
        showImagePicker()
    }
    
    @IBAction func locationButtonAction() {
        requestUserLocation()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            assetPicture = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func hideCameraButton() {
        UIView.animateWithDuration(0.25, animations: {
            self.cameraButton.alpha = 0
        }, completion: { _ in
                self.cameraButton.hidden = true
                self.cameraButton.alpha = 1
        })
    }
    
    func requestUserLocation() {
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first {
            self.userLocation = userLocation
        }
    }
    
    @IBAction func selectionButtonAction(sender: AnyObject) {
        for button in selectionButtons {
            button.selected = button === sender            
        }
    }
    
}