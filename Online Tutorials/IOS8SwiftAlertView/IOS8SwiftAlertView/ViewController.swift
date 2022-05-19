//
//  ViewController.swift
//  IOS8SwiftAlertView
//
//  Created by Alejandro on 6/3/15.
//  Copyright (c) 2015 Alejandro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func buttonTapped(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Event Sent", message:
            "Thanks for Sharing with the Community!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

