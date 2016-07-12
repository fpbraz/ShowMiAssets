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
	
	
	
	// MARK: - API
	
	static func uploadImage(image: UIImage?, completionHandler: () -> Void) {
		
		guard let image = image else {
			completionHandler()
			return
		}
		
//		dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
		
			let uploadDelegate = DelegateResponder(successHandler: completionHandler)
			let uploader = CLUploader(cloudinary, delegate: uploadDelegate)
			
			let timestamp = "\(Int(NSDate().timeIntervalSince1970))"
			let filePath = saveImage(image, withName: timestamp)
			
			uploader.upload(filePath, options: [:])
//		}
	}
	
	
	
	// MARK: - Private methods
	
	private static func saveImage(image: UIImage, withName name: String) -> String {
	
		let data: NSData = UIImageJPEGRepresentation(image, 1.0)!
		let fileManager: NSFileManager = NSFileManager.defaultManager()
		
		let fullPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent(name + ".jpeg")
		let creationResult = fileManager.createFileAtPath(fullPath.absoluteString, contents: data, attributes: nil)
		
		print("Saved file: \(creationResult)")
		
		return fullPath.absoluteString
	}
}

private class DelegateResponder: NSObject, CLUploaderDelegate {
	
	init(successHandler: () -> Void) {
		self.successHandler = successHandler
	}
	
	private let successHandler: () -> Void
	
	@objc func uploaderSuccess(result: [NSObject: AnyObject], context: AnyObject) {
//		dispatch_async(dispatch_get_main_queue()) { [successHandler] in
			successHandler()
//		}
	}
	
	// TODO: handle failure
}
