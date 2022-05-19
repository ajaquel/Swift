//
//  ViewController.swift
//  IOS8SwiftSearchMap
//
//  Created by Alejandro on 6/3/15.
//  Copyright (c) 2015 Alejandro Jaque. All rights reserved.
//
//  Found here http://www.ioscreator.com/tutorials/searching-map-view-ios8-swift
//

import UIKit
import MapKit

class ViewController: UIViewController {

    
    let initialLocation = CLLocation(latitude: 47.606822, longitude: -122.336706)
    let searchRadius: CLLocationDistance = 3000
    
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBAction func searchOnValueChanged(sender: AnyObject) {
        mapView.removeAnnotations(mapView.annotations)
        
        searchInMap()
    }
    
    
    // This will add the pin including annotation to the map.
    
    func addPinToMapView(title: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MyAnnotation(coordinate: location, title: title)
        
        mapView.addAnnotation(annotation)
    }
    
    
    
    
    func searchInMap() {
        // 1
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = segmentedControl.titleForSegmentAtIndex(segmentedControl.selectedSegmentIndex)
        // 2
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        request.region = MKCoordinateRegion(center: initialLocation.coordinate, span: span)
        // 3
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler {
            (response: MKLocalSearchResponse!, error: NSError!) in
            
            for item in response.mapItems as! [MKMapItem] {
                println("Item name = \(item.name)")
                println("Latitude = \(item.placemark.location.coordinate.latitude)")
                println("Longitude = \(item.placemark.location.coordinate.longitude)")
                
                self.addPinToMapView(item.name, latitude: item.placemark.location.coordinate.latitude, longitude: item.placemark.location.coordinate.longitude)

            }
        }     
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, searchRadius * 4.0, searchRadius * 4.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
    searchInMap()
    
    }
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

