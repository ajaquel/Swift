//
//  ViewController.swift
//  CurrentLocation
//
//  Created by Alejandro on 6/3/15.
//  Copyright (c) 2015 Alejandro Jaque. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var myMap: MKMapView!
    
    let locationManager = CLLocationManager()
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
        if error != nil
        {
            println("Error: " + error.localizedDescription)
            return
        }
        if placemarks.count > 0
        {
            let pm = placemarks[0] as! CLPlacemark
            self.displayLocationInfo(pm)
        }
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark)
    {
        
     //   self.locationManager.stopUpdatingLocation()
        
        println("")
        println("New Query")
        println(placemark.addressDictionary)
        println("")
        println(placemark.region)
        println(placemark.areasOfInterest)
        println(placemark.locality)
        println(placemark.postalCode)
        println(placemark.administrativeArea)
        println(placemark.country)

    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: " + error.localizedDescription)
    }
    
    
    
    

}

