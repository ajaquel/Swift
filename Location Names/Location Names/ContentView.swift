import SwiftUI
import MapKit
import CoreLocation
import CoreLocationUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
        
    var body: some View {
        
        ZStack(alignment: .bottom) {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
            .accentColor(Color.pink)
            .onAppear {
                viewModel.checkIfLocationServicesIsEnabled()
            }

            VStack {
                Text("\(locationDatetime)")
                    .frame(width: 420, height: 30, alignment: .center)
                    .lineLimit(1)
                    .font(.system(size: 18, weight: .light, design: .default))
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.blue)
                    .background(.white)
                    .padding(.top, 1)
                    .opacity(0.9)
                
                Text(locationLabel)
                    .frame(width: 420, height: 70, alignment: .center)
                    .lineLimit(3)
                    .font(.system(size: 18, weight: .regular, design: .default))
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.blue)
                    .background(.white)
                    .padding(.top, -7)
                    .opacity(0.9)
                
                Text("Latitude: " + String(format:"%.4f%@", locationLat, hemiNS) + ", " + "Longitude: " + String(format:"%.4f%@", locationLon, hemiEW))
                    .frame(width: 420, height: 30, alignment: .center)
                    .lineLimit(1)
                    .font(.system(size: 18, weight: .light, design: .default))
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.blue)
                    .background(.white)
                    .padding(.top, -7)
                    .opacity(0.9)
                
                Text("Elevation: \(locationAlt, specifier: "%.2f") masl")
                    .frame(width: 420, height: 30, alignment: .center)
                    .lineLimit(1)
                    .font(.system(size: 18, weight: .light, design: .default))
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.blue)
                    .background(.white)
                    .padding(.top, -7)
                    .opacity(0.9)
                
                if locationSpeed > 0 {
                    Text("Speed: " + String(format:"%.0f%@", locationSpeed, " mph / ") + String(format:"%.0f%@", locationSpeedkph, " kph") + ", " + "Direction: " + String(locationDir))
                        .frame(width: 420, height: 30, alignment: .center)
                        .lineLimit(1)
                        .font(.system(size: 18, weight: .light, design: .default))
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.blue)
                        .background(.white)
                        .padding(.top, -7)
                        .opacity(0.9)
                } else {
                    Text("Speed: Not Moving" + ", " + "Direction: " + String(locationDir))
                        .frame(width: 420, height: 30, alignment: .center)
                        .lineLimit(1)
                        .font(.system(size: 18, weight: .light, design: .default))
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.blue)
                        .background(.white)
                        .padding(.top, -7)
                        .opacity(0.9)
                }
                
                
                Spacer()
                
                Button(action: {
                    viewModel.checkIfLocationServicesIsEnabled()
                })
                    {
                        HStack {
                        Image(systemName: "location.fill")
                        Text("Current Location").foregroundColor(Color.white)
                        }
                    }
                    .padding(.bottom, 40)
                    .buttonStyle(modifiedButtonStyle())
            }
        }
    }
}

struct modifiedButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.system(size: 18))
            .foregroundColor(configuration.isPressed ? Color.pink : Color.white)
            .padding(10)
            .background(Color.blue)
            .opacity(0.8)
            .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 0, longitude: -80)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100)
    static let currentSpan = MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007)
}

var locationLabel: String = "Refresh 'Current Location'..."
var locationLat: Double = 0
var locationLon: Double = 0
var locationSpeed: Double = 0
var locationSpeedkph: Double = 0
var locationDir = ""
var locationAlt: Double = 0
var locationDatetime: String = ""

var hemiNS = ""
var hemiEW = ""

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var  region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    
    var locationManager: CLLocationManager?
    let addressManager: CLGeocoder = CLGeocoder()
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest

            let loc: CLLocation = CLLocation(
                latitude: locationManager?.location?.coordinate.latitude ?? 0,
                longitude: locationManager?.location?.coordinate.longitude ?? 0
            )
            
            addressManager.reverseGeocodeLocation(loc, completionHandler:
                {(placemarks, error) in
                if (error != nil)
                {
                    print("Reverse Geocode Fail: \(error!.localizedDescription)")
                }
                let pm = placemarks as [CLPlacemark]?
                if pm?.count ?? 0 > 0 {
                    let pm = placemarks![0]
                                        
                    print("=========================")
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
                    print("- Latitude:              ", self.locationManager?.location?.coordinate.latitude as Any)
                    print("- Longitude:             ", self.locationManager?.location?.coordinate.longitude as Any)
                    print("- Altitude:              ", self.locationManager?.location?.altitude as Any)
                    print("- Ellipsoidal Altitude:  ", self.locationManager?.location?.ellipsoidalAltitude as Any)
                    print("- Floor:                 ", self.locationManager?.location?.floor as Any)
                    print("- Vertical Accuracy:     ", self.locationManager?.location?.verticalAccuracy as Any)
                    print("- Course:                ", self.locationManager?.location?.course as Any)
                    print("- Speed:                 ", self.locationManager?.location?.speed as Any)
                    print("- Source Information:    ", self.locationManager?.location?.sourceInformation as Any)
                    print("- Timestamp:             ", self.locationManager?.location?.timestamp as Any)
                    print("- TimeStamp:             ", pm.location?.timestamp.formatted(date: .complete, time: .complete) as Any)
                    print("-------------------------")

                    locationLabel = ""
                    
                    if pm.name == "North Atlantic Ocean" {
                        let name = "Refresh 'Current Location'..."
                        locationLabel += name } else { if let name = pm.name { locationLabel += "≈ \(name)\n" } }
                    if let subLocality = pm.subLocality { locationLabel += "\(subLocality), " }
                    if let locality = pm.locality { locationLabel += "\(locality), " }
                    if let subAdministrativeArea = pm.subAdministrativeArea { locationLabel += "\(subAdministrativeArea)\n" }
                    if let administrativeArea = pm.administrativeArea { locationLabel += "\(administrativeArea), " }
                    if let postalCode = pm.postalCode { locationLabel += "\(postalCode), " }
                    if let country = pm.country { locationLabel += "\(country)" }
                    
                    if let lat = self.locationManager?.location?.coordinate.latitude { locationLat = lat }
                    if let lon = self.locationManager?.location?.coordinate.longitude { locationLon = lon }
                    
                    if locationLat >= 0 { hemiNS = "° N" } else { hemiNS = "° S" }
                    if locationLon >= 0 { hemiEW = "° E" } else { hemiEW = "° W" }
                    
                    locationAlt = self.locationManager?.location?.ellipsoidalAltitude ?? 0
                    if locationAlt < 0 { locationAlt = 0 }
                    
                    locationSpeed = self.locationManager?.location?.speed ?? 0
                    if locationSpeed < 0 { locationSpeed = 0 }
                    
                    if self.locationManager?.location?.course ?? 0 >= 340 && self.locationManager?.location?.course ?? 0 <= 360 { locationDir = "North" } else
                    { if self.locationManager?.location?.course ?? 0 >= 0 && self.locationManager?.location?.course ?? 0 <= 19 { locationDir = "North" } else
                    { if self.locationManager?.location?.course ?? 0 >= 20 && self.locationManager?.location?.course ?? 0 <= 59 { locationDir = "NorthEast" } else
                        { if self.locationManager?.location?.course ?? 0 >= 60 && self.locationManager?.location?.course ?? 0 <= 199 { locationDir = "East" } else
                            { if self.locationManager?.location?.course ?? 0 >= 120 && self.locationManager?.location?.course ?? 0 <= 159 { locationDir = "SouthEast" } else
                            { if self.locationManager?.location?.course ?? 0 >= 160 && self.locationManager?.location?.course ?? 0 <= 199 { locationDir = "South" } else
                                { if self.locationManager?.location?.course ?? 0 >= 200 && self.locationManager?.location?.course ?? 0 <= 239 { locationDir = "SouthWest" } else
                                { if self.locationManager?.location?.course ?? 0 >= 240 && self.locationManager?.location?.course ?? 0 <= 299 { locationDir = "West" } else
                                    { if self.locationManager?.location?.course ?? 0 >= 300 && self.locationManager?.location?.course ?? 0 <= 339 { locationDir = "NorthWest" } else
                                    { locationDir = "Undetected" }}}}}}}}}
                            
                    locationSpeedkph = locationSpeed * 3.6 // mps to kph
                    locationSpeed = locationSpeed * 2.237 // mps to mph

                    locationDatetime = pm.location?.timestamp.formatted(date: .complete, time: .complete) ?? ""
                    
                    print("- locationLabel:         ", locationLabel)
                    print("- Coordinates Raw:       ", "\(locationLat)" + ", " + "\(locationLon)")
                    print("- Coordinates Rounded:   ", String(format:"%.8f", locationLat) + ", " + String(format:"%.8f", locationLon))
                    print("- Compass:               ", hemiNS, hemiEW)
                    print("- LocationAlt:           ", locationAlt)
                    print("- LocationSpeed:         ", locationSpeed, String("mph"))
                    print("- LocationSpeed:         ", locationSpeedkph, String("kph"))
                    print("- LocationDir  :         ", "\(locationDir)")

                }
            })
        } else {
            print("Phone Location Services Setting is OFF")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location is Restricted")
        case .denied:
            print("Location is Denied")
        case .authorizedAlways, .authorizedWhenInUse:
            if let loc = locationManager.location {
                print("- Loc: ", loc)
                region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.currentSpan)
        }
        @unknown default:
            break
        }
    }
}
