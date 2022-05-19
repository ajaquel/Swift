//
//  ContentView.swift
//  User Location 3
//
//  Created by Alejandro on 5/2/22.
//

import SwiftUI
import MapKit
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion()
    private let manager = CLLocationManager()
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            let center = CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            region = MKCoordinateRegion(center: center, span: span)
        }
    }
}
struct ContentView: View {
    @StateObject private var manager = LocationManager()
    var body: some View {
        Map(coordinateRegion: $manager.region, showsUserLocation: true)
    }
}

