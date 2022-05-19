//
//  ViewTwo.swift
//  Passing Data
//
//  Created by Alejandro on 6/4/15.
//  Copyright (c) 2015 Alejandro Jaque. All rights reserved.
//

import Foundation
import UIKit

class ViewTwo: UIViewController {
    
    
    @IBOutlet weak var Label: UILabel!
    
    var LabelText = String()
    
    
    override func viewDidLoad() {

    Label.text = LabelText
        
    }
}