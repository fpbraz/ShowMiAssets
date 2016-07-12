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
    
    @IBOutlet weak var tagsLabel: UILabel!
    
    @IBOutlet weak var locationActivityIndicator: UIActivityIndicatorView!
    
    var userLocation: CLLocation?
    
    var imageURL: String?
    
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
        SwiftSpinner.show("Creating Asset")
        
        let asset = self.getAssetFromUI()
        asset.productCharacteristic?.picturesURLs = [imageURL!]

        self.assetManager.requestAssetCreation(asset) { response in
            SwiftSpinner.hide()
            self.performSegueWithIdentifier("assetCreationToSuccess", sender: response!.urlString)
        }
    }

    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            assetPicture = resizeImage(pickedImage)
                
            SwiftSpinner.show("Uploading Image")
            ImageUploader.uploadImage(assetPicture) { (url) in
                SwiftSpinner.sharedInstance.titleLabel.text = "Analyzing image"
                
                self.imageURL = url
                
                self.imageReconManager.fetchImageReconForImage(url!, completion: { (imageRecon) in
                    
                    if let imageRecon = imageRecon where imageRecon.tags.count > 0 {
                        
                        var result = ""
                        for tag in imageRecon.tags {
                            result += " " + tag + ","
                        }
                        
                        self.tagsLabel.text = result.substringToIndex(result.endIndex.predecessor())
                    }
                    SwiftSpinner.hide()
                })
            }
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
    
    
    func resizeImage(image: UIImage) -> UIImage {
        let size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.2, 0.2))
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
//    "name":name,
//    "owner":owner,
//    "coordinates":coordinatesString,
//    "photos":photos,
}