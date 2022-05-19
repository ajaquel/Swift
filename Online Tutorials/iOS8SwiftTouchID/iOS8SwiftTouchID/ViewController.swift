//
//  ViewController.swift
//  iOS8SwiftTouchID
//
//  Created by Alejandro on 6/3/15.
//  Copyright (c) 2015 Alejandro Jaque. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBAction func authenticateWithTouchID(sender: AnyObject) {
        // 1
        let context = LAContext()
        var error: NSError?
        
        // 2
        // check if Touch ID is available
        if context.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            // 3
            let reason = "Authenticate with Touch ID"
            context.evaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply:
                {(succes: Bool, error: NSError!) in
                    // 4
                    if succes {
                        self.showAlertController("Touch ID Authentication Succeeded")
                    }
                    else {
                        self.showAlertController("Touch ID Authentication Failed")
                    }
            })
        }
            // 5
        else {
            showAlertController("Touch ID not available")
        }
    }
    
    
    
    
    
    func showAlertController(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
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

