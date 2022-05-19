//
//  DetailViewController.swift
//  AJParseTable
//
//  Created by Alejandro Jaque on 06/05/2015.
//  Copyright (c) 2015 Alejandro Jaque. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Parse

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
	
	// Container to store the view table selected object
	var currentObject : PFObject?
	
	// Some text fields
    @IBOutlet weak var nameEvent: UITextField!
    @IBOutlet weak var typeEvent: UITextField!
    @IBOutlet weak var cityEvent: UITextField!
    @IBOutlet weak var stateEvent: UITextField!
    @IBOutlet weak var rateEvent: UITextField!
    @IBOutlet weak var commentsEvent: UITextField!
    @IBOutlet weak var picEvent: PFImageView!
	
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var currentLocation: UILabel!
    @IBOutlet weak var currentParseLocation: UILabel!
    
    @IBOutlet weak var uploadPreviewImage: UIImageView!
    @IBAction func uploadImageFromSource(sender: AnyObject) {
        
        
        // Select picture from library or Camera
        var imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // Display selected picture into preview
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        uploadPreviewImage.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
	// The save button
	@IBAction func saveButton(sender: AnyObject) {
		
		if let updateObject = currentObject as PFObject? {
			
			// Update the existing parse object
            updateObject["nameEvent"] = nameEvent.text
            updateObject["typeEvent"] = typeEvent.text
            updateObject["cityEvent"] = cityEvent.text
            updateObject["stateEvent"] = stateEvent.text
            updateObject["rateEvent"] = rateEvent.text
            updateObject["commentsEvent"] = commentsEvent.text

            
            //create a parse file to store in cloud
            if uploadPreviewImage.image == nil {
                //image is not included alert user
                println("Image not uploaded")
            } else {
            updateObject["picEvent"] = PFFile(name: "newpicEvent.png", data: UIImagePNGRepresentation(self.uploadPreviewImage.image))
            updateObject.saveInBackground()
            }
            
            
			// Create a string of text that is used by search capabilites
            var searchText = (nameEvent.text + " " + typeEvent.text + " " + cityEvent.text + " " + rateEvent.text + " " + stateEvent.text + " " + commentsEvent.text).lowercaseString
            updateObject["searchText"] = searchText

			// Save the data back to the server in a background task
			updateObject.saveEventually()
            
            } else {
            
			// Create a new parse object
            var updateObject = PFObject(className:"Events")
						
            updateObject["nameEvent"] = nameEvent.text
            updateObject["typeEvent"] = typeEvent.text
            updateObject["cityEvent"] = cityEvent.text
            updateObject["stateEvent"] = stateEvent.text
            updateObject["rateEvent"] = rateEvent.text
            updateObject["commentsEvent"] = commentsEvent.text
            //updateObject["coordinatesEvent"] = currentLocation as? PFGeoPoint
            
            
            //create a parse file to store in cloud
            if uploadPreviewImage.image == nil {
                //image is not included alert user
                println("Image not uploaded")
            } else {
                updateObject["picEvent"] = PFFile(name: "newpicEvent.png", data: UIImagePNGRepresentation(self.uploadPreviewImage.image))
                updateObject.saveInBackground()
            }

            
			// Create a string of text that is used by search capabilites
			var searchText = (nameEvent.text + " " + typeEvent.text + " " + cityEvent.text + " " + rateEvent.text + " " + stateEvent.text + " " + commentsEvent.text).lowercaseString
			updateObject["searchText"] = searchText
            
			//updateObject.ACL = PFACL(user: PFUser.currentUser()!)
			
			// Save the data back to the server in a background task
			updateObject.saveEventually()
            
        }
		
		// Return to table view
		self.navigationController?.popViewControllerAnimated(true)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Unwrap the current objects to display on detail view
		if let object = currentObject {
            nameEvent.text = object["nameEvent"] as! String
            typeEvent.text = object["typeEvent"] as! String
            cityEvent.text = object["cityEvent"] as! String
            stateEvent.text = object["stateEvent"] as! String
            rateEvent.text = object["rateEvent"] as! String
            commentsEvent.text = object["commentsEvent"] as! String
            
            // Shows big pic from Parse as PFFile
			var initialThumbnail = UIImage(named: "question")
            picEvent.image = initialThumbnail
            if let thumbnail = object["picEvent"] as? PFFile {
                picEvent.file = thumbnail
                picEvent.loadInBackground()
                
                //-------------------------------------------
                
                // Getting user current location
                var locationManager:CLLocationManager!
                
                locationManager = CLLocationManager()
                locationManager.requestAlwaysAuthorization()
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.delegate = self
                locationManager.startUpdatingLocation()
                CLLocationManager().requestAlwaysAuthorization()
                mapView.showsUserLocation = true
                mapView.delegate = self
                mapView.mapType = MKMapType.Hybrid
                
                //Centering mapView to coordenates
                var lat = locationManager.location.coordinate.latitude
                var lon = locationManager.location.coordinate.longitude
                let location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                let span = MKCoordinateSpanMake(0.002, 0.002)
                let region = MKCoordinateRegionMake(location, span)
                mapView.setRegion(region, animated: true)
                
                
                //  ***NOT WORKING*** Map Display and Region Zoom
                //let region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.location.coordinate, 2000, 2000)
//                mapView.setRegion(region, animated: true)

                   
                //Gets own current device location
                var ownLatitudeLongitude = (locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude)
                currentLocation.text = "\(ownLatitudeLongitude)"
                println("DetailViewController from Local: \(ownLatitudeLongitude)")


                //Gets coordinates from Parse column "coordinatesEvent" for every Event
                if let parseLocation = object["coordinatesEvent"] as? PFGeoPoint {
                    currentParseLocation.text = "\(parseLocation)"
                    println("DetailViewController from Parse: \(currentParseLocation.text)")
                }
                
                //   ***NOT WORKING*** to get coordinates from Parse column "coordinatesEvent"//
//                if let parseLocation = object["coordinatesEvent"] as? [PFGeoPoint("\(PFGeoPoint(latitude: Double.self, longitude: Double.self))")] {
//                    currentLocation.text = "\(parseLocation)"
//                    println(currentLocation.text)
//                }
                
                //   ***NOT WORKING*** to get coordinates from Parse column "coordinatesEvent"//
//                if let myString = ["\(PFGeoPoint()), \(PFGeoPoint())"] {
//                    cell.customParseLocation.text = myString
//
//                }

                
                // Makes a pin on the map and the annotation with coordinates
//                var annotation = MKPointAnnotation()
//                annotation.title = "\(ownLatitudeLongitude)"
//                annotation.coordinate = locationManager.location.coordinate
//                mapView.addAnnotation(annotation)
                
                
                
                //-------------------------------------------

			}
			
		}
	}
}
