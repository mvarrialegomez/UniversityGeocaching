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
    
    // Function to calculate distance between two coordinates
    func distance(from coordinate: CLLocationCoordinate2D) -> CLLocationDistance? {
        guard let userLocation = userLocation else { return nil }
        let cacheLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        return userLocation.distance(from: cacheLocation)
    }
        
    // Function to update user's current location
    func updateUserLocation() {
        locationManager.requestLocation()
    }
    
    // Function to sort caches by distance from user location
    func sortCachesByDistance() -> [CacheDetail] {
        guard let userLocation = userLocation else { return availCaches }
        return availCaches.sorted { cache1, cache2 in
            guard let distance1 = distance(from: cache1.location),
                  let distance2 = distance(from: cache2.location) else {
                return false
            }
            return distance1 < distance2
        }
    }
    
    let availCaches = [
        CacheDetail(title: "Warren Hall", location: CLLocationCoordinate2D(latitude: 32.77154, longitude:  -117.18884), questionPage: CacheQuestionsPageView(question: "Question 1", options: ["Option 1", "Option 2","Option 3", "Option 4"], correctOptionIndex: 0)),
        CacheDetail(title: "Student Life Pavilion", location: CLLocationCoordinate2D(latitude: 32.77244, longitude: -117.18727), questionPage: CacheQuestionsPageView(question: "Question 2", options: ["Option A", "Option B", "Option C", "Option D"], correctOptionIndex: 0)),
        CacheDetail(title: "Copely Library", location: CLLocationCoordinate2D(latitude: 32.771443, longitude: -117.193472), questionPage: CacheQuestionsPageView(question: "Question 3", options: ["Option X", "Option Y", "Option Z", "Option AA"], correctOptionIndex: 0)),
        CacheDetail(title: "USD Torero Store", location: CLLocationCoordinate2D(latitude: 32.772364, longitude: -117.187653), questionPage: CacheQuestionsPageView(question: "Question 4", options: ["Option Alpha", "Option Beta", "Option Charlie", "Option Delta"], correctOptionIndex: 0))
    ]
    
    var body: some View {
        VStack {
            Text("Available Caches")
                .font(.system(size: 30))
                .bold()
            
            List(sortCachesByDistance(), id: \.title) { cache in
                NavigationLink(destination: cache.questionPage) {
                    VStack(alignment: .leading) {
                        Text(cache.title)
                            .font(.headline)
                        Text("Coordinates: \(cache.locationString)") // Use the locationString property here
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .padding(.bottom, 2)
                        
                        if let distance = distance(from: cache.location) {
                            Text(String(format: "%.2f meters away", distance))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        } else {
                            Text("Distance unknown")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
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
}

struct CacheDetail {
    var title: String
    var location: CLLocationCoordinate2D
    var questionPage: CacheQuestionsPageView // Use the actual type here
    
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
