//
//  ViewController.swift
//  IOS8SwiftPostFacebook
//
//  Created by Alejandro on 6/3/15.
//  Copyright (c) 2015 Alejandro Jaque. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func postToFacebook(sender: UIButton) {
        // 1
        if SLComposeViewController.isAvailableForServiceType(sl
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            // 2
            var controller = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            // 3
            controller.setInitialText("Testing Posting to Facebook")
            // 4
            self.presentViewController(controller, animated:true, completion:nil)
        }
        else {
            // 3
            println("no Facebook account found on device")
        }
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

