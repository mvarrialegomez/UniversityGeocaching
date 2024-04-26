//  Geocaches.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 3/14/23.
//  Continued by Maria Varriale Gomez, David Amano, Natalie Nguyen, Michael Gallagher, and Sean Limqueco in Spring 2024.
//

import SwiftUI
import CoreLocation

struct Geocaches: View {
    @StateObject private var locationManager = LocationManager()
    @State private var userLocation: CLLocation?
    
    let availCaches = [
        CacheDetail(title: "Warren Hall", location: CLLocationCoordinate2D(latitude: 32.7757, longitude: -117.0719), completionDate: "2024-03-01"),
        CacheDetail(title: "Student Life Pavilion", location: CLLocationCoordinate2D(latitude: 32.7777, longitude: -117.0724), completionDate: "2024-02-15"),
        CacheDetail(title: "Copely Library", location: CLLocationCoordinate2D(latitude: 32.7723, longitude: -117.0716), completionDate: "2024-01-20")
    ]
    
    var body: some View {
        VStack {
            Text("Available Caches")
                .font(.system(size: 30))
                .bold()
            
            List(availCaches, id: \.title) { cache in
                VStack(alignment: .leading) {
                    Text(cache.title)
                        .font(.headline)
                    Text(cache.locationString) // Use the locationString property here
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 2)
                    
                    if let distance = distance(from: cache.location) {
                        Text(String(format: "%.2f meters away", distance))
                            .font(.footnote)
                            .foregroundColor(.gray)
                    } else {
                        Text("Distance unknown")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    
                    Text(cache.completionDate)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
        }
        .onAppear {
            locationManager.requestLocation()
        }
        .onReceive(locationManager.$location) { location in
            userLocation = location
        }
    }
}

struct CacheDetail {
    var title: String
    var location: CLLocationCoordinate2D
    var completionDate: String
    
    // Computed property to convert CLLocationCoordinate2D to a formatted string
    var locationString: String {
        return "\(location.latitude), \(location.longitude)"
    }
}

struct Geocaches_Previews: PreviewProvider {
    static var previews: some View {
        Geocaches()
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() // Request authorization
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
