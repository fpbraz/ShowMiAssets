//
//  AddProductViewController.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-11.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import UIKit
import SwiftSpinner
import CoreLocation

class AddProductViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
 
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ownerTextField: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var locationActivityIndicator: UIActivityIndicatorView!
    
    var userLocation: CLLocation?
    
    lazy var assetManager: AssetManager = {
        return AssetManager()
    }()
    
    lazy var locationManager: CLLocationManager = {
        return CLLocationManager()
    }()
    
    lazy var geocoderManager: GeocoderManager = {
        return GeocoderManager()
    }()
    
    lazy var imageReconManager: ImageReconManager = {
        return ImageReconManager()
    }()
    
    var assetPicture: UIImage? {
        didSet {
            imageView.image = assetPicture
            hideCameraButton()
            updateUI()
        }
    }
    
    lazy var imagePickerController: UIImagePickerController = {
        let imagePicker =  UIImagePickerController()
        imagePicker.sourceType = .Camera
        
        return imagePicker
    }()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        requestUserLocation()

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "assetCreationToSuccess" {
            let destinationVC = segue.destinationViewController as! AssetCreationSuccesViewController
            destinationVC.url = sender as? String
        }
    }
    
    @IBAction func photoButtonAction() {
        showImagePicker()
    }
    
    private func showImagePicker() {
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func createButtonAction(sender: AnyObject) {
        SwiftSpinner.show("Uploading Image")
        ImageUploader.uploadImage(imageView.image) { (url) in
            let asset = self.getAssetFromUI()
            asset.productCharacteristic?.picturesURLs = [url!]
            SwiftSpinner.sharedInstance.titleLabel.text = "Analyzing image"
            
            self.imageReconManager.fetchImageReconForImage(url!, completion: { (imageRecon) in
                SwiftSpinner.sharedInstance.titleLabel.text = "Creating Asset"
                
                self.assetManager.requestAssetCreation(asset) { response in
                    SwiftSpinner.hide()
                    self.performSegueWithIdentifier("assetCreationToSuccess", sender: response!.urlString)
                }
            })
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            assetPicture = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func hideCameraButton() {
        UIView.animateWithDuration(0.25, animations: {
            self.cameraButton.alpha = 0
            }, completion: { _ in
                self.cameraButton.hidden = true
                self.cameraButton.alpha = 1
        })
    }
    
    private func updateUI() {
        createButton.enabled = (imageView.image != nil && nameTextField.text != "" && ownerTextField.text != ""  && location.text != "")
    }
    
    func getAssetFromUI() -> Asset {
        let asset = Asset()
        
        asset.name = nameTextField.text
        
        let productCharacteristic = ProductCharacteristic()
        productCharacteristic.name = ownerTextField.text
        productCharacteristic.latitude = self.userLocation?.coordinate.latitude
        productCharacteristic.longitude = self.userLocation?.coordinate.longitude
        asset.productCharacteristic = productCharacteristic
        
        return asset
    }
    
    private func requestUserLocation() {
        self.locationActivityIndicator.startAnimating()
        
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
        
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first {
            self.userLocation = userLocation
            manager.stopUpdatingLocation()
            
            geocoderManager.fetchAddress(userLocation.coordinate, completion: { (address) in
                self.locationActivityIndicator.stopAnimating()
                if let address = address {
                    self.location.text = address
                }
            })
        }
    }    
}