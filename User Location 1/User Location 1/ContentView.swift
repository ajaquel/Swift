//
//  ContentView.swift
//  User Location 1
//
//  Created by Alejandro on 5/2/22.
//

import MapKit
import SwiftUI
import CoreLocation
import CoreLocationUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()

    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
            .accentColor(Color(.systemPink))
            .onAppear {
                viewModel.checkIfLocationServicesIsEnabled()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
        
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37, longitude: -121), span: MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007))
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.delegate = self

        } else {
            print("alert Location Services are not ON")
        }
    
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }

        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Restricted")
        case .denied:
            print("NotDenied")
        case .authorizedAlways, .authorizedWhenInUse:
            
            if let loc = locationManager.location{
                print("loc: ", loc)
                region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007))
            }
        @unknown default:
            break
        }
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        checkLocationAuthorization()
    }
}
