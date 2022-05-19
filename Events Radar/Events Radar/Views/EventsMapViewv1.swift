//
//  EventsMapView.swift
//  Events Radar
//
//  Created by Alejandro on 5/5/22.
//

import SwiftUI
import MapKit
import CoreLocation

struct EventsMapViewv1: View {
    
    @StateObject private var viewModel = ContentViewModelv1()
    


    
    var body: some View {
        
        VStack {
            Text("Events Map View")
                .fontWeight(.thin)
                .padding()
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hue: 0.553, saturation: 0.784, brightness: 0.644))
                .foregroundColor(.white)
            
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .padding(.top, -7)
                .onAppear {
                    viewModel.checkIfLocationServicesIsEnabled()
                }
        }
    }
}

struct EventsMapViewv1_Previews: PreviewProvider {
    static var previews: some View {
        EventsMapView()
    }
}


final class ContentViewModelv1: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 19, longitude: -80), span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.delegate = self
        } else {
            print("Get Location Services ON please")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location Services Restricted")
        case .denied:
            print("Location Services Denied")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        @unknown default:
            break
        }

    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        region = MKCoordinateRegion(center: locationManager?.location!.coordinate ?? CLLocationCoordinate2D(latitude: 19, longitude: -80), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))    }
}
