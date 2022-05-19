//
//  ViewController.swift
//  AJMapKit
//
//  Created by Alejandro on 6/3/15.
//  Copyright (c) 2015 Alejandro Jaque. All rights reserved.

import UIKit
import MapKit
import CoreLocation
import Parse

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var myAddressView: UILabel!
    @IBOutlet weak var myLocationVIew: UILabel!
  
    @IBOutlet weak var myParseOwnLocation: UILabel!
    

    
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.mapType = MKMapType.Hybrid
        CLLocationManager().requestAlwaysAuthorization()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Map Display and Region Zoom
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let regionToZoom = MKCoordinateRegionMake(manager.location.coordinate, MKCoordinateSpanMake(0.002, 0.002))
        
        mapView.setRegion(regionToZoom, animated: true)

        myLocationVIew.text = "\(locationManager.location)"
        
        // Makes a pin on the map and the annotation with coordinates
        //var annotation = MKPointAnnotation()
        //annotation.title = "\(ownLatitudeLongitude)"
        //annotation.coordinate = locationManager.location.coordinate
        //mapView.addAnnotation(annotation)

        
        //--------------------------------------------
        
        //getting and printing myOwnLocation
        
        var ownLatitudeLongitude = (locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude)
        myParseOwnLocation.text = "\(ownLatitudeLongitude)"
        println("Local Coordinates: \(ownLatitudeLongitude)")
        
        //--------------------------------------------

        
        // Gets the Address Info from Apple Servers
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
                if error != nil {
                    println("Error: " + error.localizedDescription)
                    return
                }
                if placemarks.count > 0 {
                    let pm = placemarks[0] as! CLPlacemark
                    self.displayLocationInfo(pm)
                }
            })
        }
    
        func displayLocationInfo(placemark: CLPlacemark) {
            
            // This Section stops updating location constantly.
            //   self.locationManager.stopUpdatingLocation()
            
            
            // This Section display address parameters in a column on UILabel
//            var address = ((placemark.subThoroughfare), (placemark.thoroughfare), (placemark.subLocality), (placemark.locality), (placemark.postalCode), (placemark.administrativeArea), (placemark.country))
//            myAddressView.text = "\(address)"
            
            // This Section display address parameters better formatted on UILabel
            myAddressView.text = " \(placemark.subThoroughfare) \(placemark.thoroughfare) (\(placemark.subLocality)) \r \(placemark.locality), \(placemark.administrativeArea) \(placemark.postalCode) \r \(placemark.country)"
         
//            println("-----START UPDATE-----")
//            println(placemark.subThoroughfare)
//            println(placemark.thoroughfare)
//            println(placemark.locality)
//            println(placemark.postalCode)
//            println(placemark.administrativeArea)
//            println(placemark.country)
//            println("--------------------")
//            println("*** location: ***")
//            println(locationManager.location)
//            println("--------------------")
//            println("*** addressDictionary: ***")
//            println(placemark.addressDictionary)
//            println("-----END OF UPDATE-----")
            
        }
    
        func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
            print("Error: " + error.localizedDescription)
        }

}


