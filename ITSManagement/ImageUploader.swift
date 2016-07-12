//
//  ImageUploader.swift
//  ITSManagement
//
//  Created by Zap on 12/07/16.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import Foundation
import Cloudinary

final class ImageUploader {
	
	
	// MARK: - Private properties
	
	private static var cloudinary: CLCloudinary = {
		return CLCloudinary(url: "cloudinary://739154537548145:3-z4uh9avjIjqrIu4m2pH9NQ0LA@darihxcjv")
	}()
	
	private static var runningUploads: [String : DelegateResponder] = [:]
	
	
	
	// MARK: - API
	
	static func uploadImage(image: UIImage?, completionHandler: (String?) -> Void) {
		
		guard let image = image else {
			completionHandler(nil)
			return
		}
		
		dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
		
			let timestamp = "\(Int(NSDate().timeIntervalSince1970))"
			let filePath = saveImage(image, withName: timestamp)

			let uploadDelegate = DelegateResponder(completionHandler: { photoUrl in
				completionHandler(photoUrl)
				self.runningUploads.removeValueForKey(filePath)
			})
			let uploader = CLUploader(cloudinary, delegate: uploadDelegate)

			
			uploader.upload(filePath, options: [:])
			
			runningUploads[filePath] = uploadDelegate
		}
	}
		
	// MARK: - Private methods
	
	private static func saveImage(image: UIImage, withName name: String) -> String {
	
		let data: NSData = UIImageJPEGRepresentation(image, 1.0)!
		let directory = NSTemporaryDirectory() as NSString
		let fullPathString = directory.stringByAppendingPathComponent("\(name).jpeg")
		
		do {
			try data.writeToFile(fullPathString, options: .AtomicWrite)
		}
		catch let error as NSError {
			print("Error: \(error)")
		}

		return fullPathString
	}
}

private class DelegateResponder: NSObject, CLUploaderDelegate {
	
	init(completionHandler: (photoUrl: String?) -> Void) {
		self.completionHandler = completionHandler
	}
	
	private let completionHandler: (photoUrl: String?) -> Void
	
	@objc func uploaderSuccess(result: [NSObject: AnyObject], context: AnyObject) {
		
		let imageID = result["public_id"] as! String
		
		dispatch_async(dispatch_get_main_queue()) { [completionHandler] in
			
			let photoUrl = ImageUploader.cloudinary.url(imageID.stringByAppendingString(".jpeg"))
			completionHandler(photoUrl: photoUrl)
		}
	}
	
	@objc func uploaderProgress(bytesWritten: Int, totalBytesWritten: Int, totalBytesExpectedToWrite: Int, context: AnyObject!) {
		
	}
	
	@objc func uploaderError(result: String!, code: Int, context: AnyObject!) {
		dispatch_async(dispatch_get_main_queue()) { [completionHandler] in
			completionHandler(photoUrl: nil)
		}
	}
	
}
