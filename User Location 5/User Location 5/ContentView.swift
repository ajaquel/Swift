//
//  ContentView.swift
//  User Location 5
//
//  Created by Alejandro on 5/2/22.
//


import CoreLocationUI
import CoreLocation
import MapKit
import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .ignoresSafeArea()
            
            VStack {

                Text(locationLabel)
                    .frame(width: 420, height: 70, alignment: .center)
                    .lineLimit(3)
                    .font(.system(size: 18, weight: .light, design: .default))
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .background(.white)
                    .padding(.top, 1)
                    .opacity(0.9)
                
                Text("Lat: \(locationLat)," + " " + "Lon: \(locationLon)")
                    .frame(width: 420, height: 30, alignment: .center)
                    .lineLimit(1)
                    .font(.system(size: 18, weight: .ultraLight, design: .default))
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .background(.white)
                    .padding(.top, -7)
                    .opacity(0.9)
                
                Spacer()
                
                LocationButton(.currentLocation) {
                    viewModel.requestAllowOnceLocationPermission()
                    viewModel.getAddressFromLatLon(pdblLatitude: locationLat, pdblLongitude: locationLon)
                }
                .frame(height: 40, alignment: .center)
                .foregroundColor(.white)
                .cornerRadius(10)
                .labelStyle(.titleAndIcon)
                .symbolVariant(.fill)
                .tint(.blue)
                .opacity(0.8)
                .padding(.bottom, 40)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Default Variables
public var locationLat: Double = 0
public var locationLon: Double = 0
var locationLabel: String = "Processing Coordinates..."

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(), span: MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007))
    
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestAllowOnceLocationPermission() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else {
            return
        }
        
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(center: latestLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007))
        }
        
        // Reads Coordinates
        locationLat = locations.last?.coordinate.latitude ?? 0
        locationLon = locations.last?.coordinate.longitude ?? 0
        print(locationLat, locationLon)

        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    // Gets Address Info from Coordinates
    func getAddressFromLatLon(pdblLatitude: Double, pdblLongitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double(pdblLatitude)
        let lon: Double = Double(pdblLongitude)
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)

        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]

                if pm.count > 0 {
                    let pm = placemarks![0]

                    print("- Full Place:            ", pm as Any)
                    print("- Name:                  ", pm.name as Any)
                    print("- SubLocality:           ", pm.subLocality as Any)
                    print("- Locality:              ", pm.locality as Any)
                    print("- SubAdministrativeArea: ", pm.subAdministrativeArea as Any)
                    print("- AdministrativeArea:    ", pm.administrativeArea as Any)
                    print("- PostalCode:            ", pm.postalCode as Any)
                    print("- Country:               ", pm.country as Any)
                    print("- IsoCountryCode:        ", pm.isoCountryCode as Any)
                    print("- TimeZone:              ", pm.timeZone as Any)
                    print("- Location:              ", pm.location as Any)
                    print("- AreasOfInterest:       ", pm.areasOfInterest as Any)
                    print("- InlandWater:           ", pm.inlandWater as Any)
                    print("- Ocean:                 ", pm.ocean as Any)
                    print("- Region:                ", pm.region as Any)
                    print("- Thoroughfare:          ", pm.thoroughfare as Any)
                    print("- SubThoroughfare:       ", pm.subThoroughfare as Any)

                    locationLabel = ""
        
                    if let name = pm.name {
                        locationLabel += "\(name)\n"
                    }
                    if let subLocality = pm.subLocality {
                        locationLabel += "\(subLocality), "
                    }
                    if let locality = pm.locality {
                        locationLabel += "\(locality), "
                    }
                    if let subAdministrativeArea = pm.subAdministrativeArea {
                        locationLabel += "\(subAdministrativeArea)\n"
                    }
                    if let administrativeArea = pm.administrativeArea {
                        locationLabel += "\(administrativeArea), "
                    }
                    if let postalCode = pm.postalCode {
                        locationLabel += "\(postalCode), "
                    }
                    if let country = pm.country {
                        locationLabel += "\(country)"
                    }
                    
                    print("locationLabel: ", locationLabel)
              }
        })
    }
    
    
    
}

