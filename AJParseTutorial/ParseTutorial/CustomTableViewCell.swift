//
//  CustomTableViewCell.swift
//  AJParseTable
//
//  Created by Alejandro Jaque on 06/05/2015.
//  Copyright (c) 2015 Alejandro Jaque. All rights reserved.
//

import UIKit

class CustomTableViewCell: PFTableViewCell {
	
	@IBOutlet weak var customNameEvent: UILabel!
	@IBOutlet weak var customTypeEvent: UILabel!
    @IBOutlet weak var customPicEvent: PFImageView!
    @IBOutlet weak var customCityEvent: UILabel!
    @IBOutlet weak var customStateEvent: UILabel!
    @IBOutlet weak var customRateEvent: UILabel!
    
    @IBOutlet weak var customParseLocation: UILabel!
    
    
}
