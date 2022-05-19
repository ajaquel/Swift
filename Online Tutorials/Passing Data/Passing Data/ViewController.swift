//
//  ViewController.swift
//  Passing Data
//
//  Created by Alejandro on 6/4/15.
//  Copyright (c) 2015 Alejandro Jaque. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var DestViewController : ViewTwo = segue.destinationViewController as! ViewTwo
        
        DestViewController.LabelText = TextField.text
        
        
        
        
    }
    

}

