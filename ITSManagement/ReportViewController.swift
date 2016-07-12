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
    
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet var selectionButtons: [SelectionButton]!
<<<<<<< 3bf927e170c1848dc83540df0c87d18c0740ad55
    
    @IBOutlet weak var locationActivityIndicator: UIActivityIndicatorView!
    
=======
	@IBOutlet var reportButton: UIBarButtonItem!
	
>>>>>>> Added Cloudinary for image upload
    var userLocation: CLLocation?
    
    lazy var geocoderManager: GeocoderManager = {
       return GeocoderManager()
    }()
    
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
			updateUI()
        }
    }
	
	
	// MARK: - UIViewController
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		updateUI()
	}

	
	// MARK: - User actions handling
	
    @IBAction func photoButtonAction(sender: AnyObject) {
        showImagePicker()
    }
    
    @IBAction func locationButtonAction() {
        requestUserLocation()
    }
	
	@IBAction func selectionButtonAction(sender: AnyObject) {
		
		for button in selectionButtons {
			if button === sender {
				button.selected = !button.selected
			} else {
				button.selected = false
			}
		}
		
		updateUI()
	}

	@IBAction func reportButtonAction() {
		sendReport()
	}
	
	
	// MARK: - UIImagePickerControllerDelegate
	
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            assetPicture = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
	
	
	// MARK: - CLLocationManagerDelegate
	
	func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let userLocation = locations.first {
			self.userLocation = userLocation
			manager.stopUpdatingLocation()
			
			geocoderManager.fetchAddress(userLocation.coordinate, completion: { (address) in
				self.locationActivityIndicator.stopAnimating()
				if let address = address {
					self.locationButton.setTitle(address, forState: .Normal)
				}
			})
			
		}
	}
	
	
	// MARK: - Private methods
	
	private func hideCameraButton() {
		UIView.animateWithDuration(0.25, animations: {
			self.cameraButton.alpha = 0
			}, completion: { _ in
				self.cameraButton.hidden = true
				self.cameraButton.alpha = 1
		})
	}
	
	private func requestUserLocation() {
		self.locationButton.enabled = false
		self.locationActivityIndicator.startAnimating()
		
		locationManager.delegate = self
		
		if CLLocationManager.authorizationStatus() == .NotDetermined {
			locationManager.requestWhenInUseAuthorization()
		} else {
			locationManager.startUpdatingLocation()
		}
		
	}
	
	private func showImagePicker() {
		imagePickerController.delegate = self
		presentViewController(imagePickerController, animated: true, completion: nil)
	}
	
<<<<<<< 3bf927e170c1848dc83540df0c87d18c0740ad55
>>>>>>> code beautifying
=======
	private func sendReport() {

		ImageUploader.uploadImage(assetPicture) {
			print("Image uploading finished")
			// TODO: send post request to ticket
		}
	}
	
	private func updateUI() {

//		let pictureSelected = assetPicture != nil
		let issueTypeSelected = selectionButtons.reduce(false) { (result, button) -> Bool in
			return result || button.selected
		}
		
		reportButton.enabled = issueTypeSelected
	}
	
>>>>>>> Added Cloudinary for image upload
}