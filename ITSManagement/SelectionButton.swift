//
//  SelectionButton.swift
//  ITSManagement
//
//  Created by Felipe P Braz on 2016-07-11.
//  Copyright © 2016 ITSManagement. All rights reserved.
//

import UIKit

class SelectionButton: UIButton {
    override var selected: Bool {
        didSet {
            if selected {
                backgroundColor = UIColor.blueColor()
            } else {
                backgroundColor = UIColor.lightGrayColor()
            }
        }
    }
}
