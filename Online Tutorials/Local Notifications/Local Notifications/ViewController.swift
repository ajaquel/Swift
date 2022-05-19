//
//  ViewController.swift
//  Local Notifications
//
//  Created by Alejandro on 6/2/15.
//  Copyright (c) 2015 Alejandro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

    
        var dateComp:NSDateComponents = NSDateComponents()
        dateComp.year = 2015;
        dateComp.month = 06;
        dateComp.day = 02;
        dateComp.hour = 13;
        dateComp.minute = 24;
        dateComp.timeZone = NSTimeZone.systemTimeZone()
        
        var calender:NSCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        var date:NSDate = calender.dateFromComponents(dateComp)
        
        
        var notification:UILocalNotification = UILocalNotification()
        notification.category = "FIRST_CATEGORY"
        notification.alertBody = "Hi, I am a notification"
        notification.fireDate = date
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        
    
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

