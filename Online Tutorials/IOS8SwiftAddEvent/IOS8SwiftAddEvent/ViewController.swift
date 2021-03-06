//
//  ViewController.swift
//  IOS8SwiftAddEvent
//
//  Created by Alejandro on 6/3/15.
//  Copyright (c) 2015 Alejandro Jaque. All rights reserved.
//
// Found here: http://www.ioscreator.com/tutorials/add-event-calendar-tutorial-ios8-swift
//


import UIKit
import EventKit

class ViewController: UIViewController {

    
    
    func insertEvent(store: EKEventStore) {
        // 1
        let calendars = store.calendarsForEntityType(EKEntityTypeEvent)
            as! [EKCalendar]
        
        for calendar in calendars {
            // 2
            if calendar.title == "testcalendar" {
                // 3
                let startDate = NSDate()
                // 2 hours
                let endDate = startDate.dateByAddingTimeInterval(2 * 60 * 60)
                
                // 4
                // Create Event
                var event = EKEvent(eventStore: store)
                event.calendar = calendar
                
                event.title = "New Meeting"
                event.startDate = startDate
                event.endDate = endDate
                
                // 5
                // Save Event in Calendar
                var error: NSError?
                let result = store.saveEvent(event, span: EKSpanThisEvent, error: &error)
                
                if result == false {
                    if let theError = error {
                        println("An error occured \(theError)")
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        let eventStore = EKEventStore()
        
        // 2
        switch EKEventStore.authorizationStatusForEntityType(EKEntityTypeEvent) {
        case .Authorized:
            insertEvent(eventStore)
        case .Denied:
            println("Access denied")
        case .NotDetermined:
            // 3
            eventStore.requestAccessToEntityType(EKEntityTypeEvent, completion:
                {[weak self] (granted: Bool, error: NSError!) -> Void in
                    if granted {
                        self!.insertEvent(eventStore)
                    } else {
                        println("Access denied")
                    }
                })
        default:
            println("Case Default")
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

