//
//  SuccessViewController.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-12.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {
    
    @IBAction func goBackHomeButtonAction() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}