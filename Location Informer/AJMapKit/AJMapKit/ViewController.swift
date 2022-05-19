//
//  ViewController.swift
//  AJMapKit
//
//  Created by Alejandro on 6/3/15.
//  Copyright (c) 2015 Alejandro Jaque. All rights reserved.

import UIKit
import MapKit
import CoreLocation
import iAd

//Removes space (" ") from string and encode url
extension String {
    var removeSpace:String {
        return components(separatedBy: CharacterSet(charactersIn: " ")).joined(separator: "_")
    }
    var codedWebUrl:URL {
        return URL(string: addingPercentEscapes(using: String.Encoding.utf8)!)!
    }
}

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, ADBannerViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var myAddressView: UILabel!
    @IBOutlet weak var myLocationVIew: UILabel!
    @IBOutlet weak var myFullLocationView: UILabel!
    @IBOutlet weak var adBannerView: ADBannerView!
    
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // iAds Configugation (1)
        //self.canDisplayBannerAds = true
        //self.adBannerView?.delegate = self
        //self.adBannerView?.isHidden = true
        // ends iAds Configugation (1)

        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.mapType = MKMapType.hybrid
        CLLocationManager().requestAlwaysAuthorization()
    }
    
    // iAds Configugation (2)
    //func bannerViewWillLoadAd(_ banner: ADBannerView!) {
    //}
    //func bannerViewDidLoadAd(_ banner: ADBannerView!) {
    //    self.adBannerView?.isHidden = false
    //}
    //func bannerViewActionDidFinish(_ banner: ADBannerView!) {
    //}
    //func bannerViewActionShouldBegin(_ banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
    //    return true
    //}
    //func bannerView(_ banner: ADBannerView!, didFailToReceiveAdWithError error: Error!) {
    //}
    // ends iAds Configugation (2)

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Map Display and Region Zoom
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let regionToZoom = MKCoordinateRegionMake(manager.location!.coordinate, MKCoordinateSpanMake(0.050, 0.050))
        
        mapView.setRegion(regionToZoom, animated: true)

//        myLocationVIew.text = "\(locationManager.location.coordinate.latitude) \(locationManager.location.coordinate.longitude)"
//        myFullLocationView.text = "\(locationManager.location)"
//        println("myLocationView: \(myLocationVIew.text)")
//        println("myFullLocationView: \(myFullLocationView.text)")
        
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: { (placemarks, error) -> Void in
                if error != nil {
                    print("Error: " + error!.localizedDescription)
                    return
                }
            
                if placemarks!.count > 0 {
                    let pm = placemarks![0] as! CLPlacemark
                    self.displayLocationInfo(pm)
                }else{
                    print("Problem with the data received from geocoder")
            }
            })
        }
    


    @IBOutlet weak var webView: UIWebView!
    
    
        func displayLocationInfo(_ placemark: CLPlacemark) {
            
            // This Section stops updating location constantly.
            self.locationManager.stopUpdatingLocation()
            
            // This Section display address parameters better formatted UILabel
            myAddressView.text = " \(placemark.subThoroughfare) \(placemark.thoroughfare) (\(placemark.subLocality)) \r \(placemark.locality), \(placemark.administrativeArea) \(placemark.postalCode) \r \(placemark.country)"
            
            
//            let formattedAddress: (AnyObject?) = (placemark.addressDictionary["address.FormattedAddressLines"])
//            myAddressView.text = "\(formattedAddress)"
         
            //println("-----PLACEMARK START UPDATE-----")
            //println("*** placemark.addressDictionary[FormattedAddressLines]: ***")
            //println(placemark.addressDictionary["FormattedAddressLines"])
//            println(placemark.addressDictionary["FormattedAddressLines"] as! NSString)
//            println("--------------------")
//            println("*** placemark.lat/lon: ***")
//            println(placemark.location.coordinate.latitude)
//            println(placemark.location.coordinate.longitude)
            //println("--------------------")
            //println("*** placemark.individuals: ***")
            //println("subThoroughfare: ", placemark.subThoroughfare)
            //println("thoroughfare: ", placemark.thoroughfare)
            //println("subLocality: ", placemark.subLocality)
            //println("locality: ", placemark.locality)
            //println("postalcode: ", placemark.postalCode)
            //println("subAdministrativeArea: ", placemark.subAdministrativeArea)
            //println("administrativeArea: ", placemark.administrativeArea)
            //println("country: ", placemark.country)
            //println("ISOcountryCode: ", placemark.ISOcountryCode)
            //println("region: ", placemark.region)
            //println("inlandWater: ", placemark.inlandWater)
            //println("ocean: ", placemark.ocean)
            //println("name: ", placemark.name)
//            println("--------------------")
//            println("*** locationManager.location: ***")
//            println(locationManager.location)
//            println("--------------------")
//            println("*** placemark.addressDictionary: ***")
//            println(placemark.addressDictionary)
//            println("--------------------")
//            println("*** placemark: ***")
//            println("\(placemark)")
            //println("-----END OF UPDATE-----")
    
            // Query WEBSITE
            
            
            
   
//            let url1: NSURL! = NSURL(string: "https://en.wikipedia.org/?search=\(placemark.locality)")
            let addressSubLocality = "https://en.m.wikipedia.org/?search=\(placemark.subLocality)"
            let url0 = addressSubLocality.removeSpace.codedWebUrl
            
//            let url1: NSURL! = NSURL(string: "https://en.wikipedia.org/?search=\(placemark.locality)")
            let addressLocality = "https://en.m.wikipedia.org/?search=\(placemark.locality)"
            let url1 = addressLocality.removeSpace.codedWebUrl
            
//            let url2: NSURL! = NSURL(string: "https://en.wikipedia.org/?search=\(placemark.administrativeArea)")
            let addressAdminArea = "https://en.m.wikipedia.org/?search=\(placemark.administrativeArea)"
            let url2 = addressAdminArea.removeSpace.codedWebUrl
            
//            let url3: NSURL! = NSURL(string: "https://en.wikipedia.org/?search=\(placemark.country)")
            let addressCountry = "https://en.m.wikipedia.org/?search=\(placemark.country)"
            let url3 = addressCountry.removeSpace.codedWebUrl
            
            print("")
            print("\(placemark.subLocality), \(placemark.locality), \(placemark.administrativeArea), \(placemark.country)")
            
            if "\(placemark.locality)" != "nil" {
                print("LOCALITY IS: \(url1)")
                webView.loadRequest(URLRequest(url: url1))

            } else if "\(placemark.administrativeArea)" != "nil" {
                print("ADMINAREA IS: \(url2)")
                webView.loadRequest(URLRequest(url: url2))
                
            } else if "\(placemark.country)" != "nil"{
                print("COUNTRY IS: \(url3)")
                webView.loadRequest(URLRequest(url: url3))

            }
        }
    
    
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Error: " + error.localizedDescription)
        }
    
    @IBAction func refreshLocation(_ sender: AnyObject) {
        locationManager.startUpdatingLocation()
    }

}
