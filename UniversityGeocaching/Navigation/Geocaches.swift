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
    func sortCachesByDistance() -> [Cache] {
        guard let userLocation = userLocation else { return availCaches! }
        return (availCaches!.sorted { cache1, cache2 in
            guard let distance1 = distance(from: cache1.coordinate),
                  let distance2 = distance(from: cache2.coordinate) else {
                return false
            }
            return distance1 < distance2
        })
    }
    
    let availCaches = readCacheCSV()
    
    var body: some View {
        VStack {
            Text("Available Caches")
                .font(.system(size: 30))
                .bold()
                .padding(.bottom, 2)
            
            Text("Caches will become available when you are within 10m of the cache")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            List(sortCachesByDistance(), id: \.name) { cache in
                if let distance = distance(from: cache.coordinate) {
                    if distance <= 100 {
                        // Navigate to the next page only if the user is 100 meters or less away from the cache
                        VStack(alignment: .leading) {
                            NavigationLink(destination: CacheQuestionsPageView(question: cache.question, correctAnswer: cache.correctAnswer, answer2: cache.answer2, answer3: cache.answer3, answer4: cache.answer4)) {
                                VStack(alignment: .leading) {
                                    Text(cache.name)
                                        .font(.headline)
                                    Text("Coordinates: \(cache.coordinate.latitude), \(cache.coordinate.longitude)")
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                        .padding(.bottom, 2)
                                    Text(String(format: "%.2f meters away", distance))
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    } else {
                        // Show a disabled button if the user is more than 10 meters away
                        VStack(alignment: .leading) {
                            Button(action: {}) {
                                VStack(alignment: .leading) {
                                    Text(cache.name)
                                        .font(.headline)
                                    Text("Coordinates: \(cache.coordinate.latitude), \(cache.coordinate.longitude)")
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                        .padding(.bottom, 2)
                                    Text(String(format: "%.2f meters away", distance))
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            .disabled(true)
                        }
                    }
                } else {
                    // Show a disabled button if the distance is unknown
                    VStack(alignment: .leading) {
                        Button(action: {}) {
                            VStack(alignment: .leading) {
                                Text(cache.name)
                                    .font(.headline)
                                Text("Coordinates: \(cache.coordinate.latitude), \(cache.coordinate.longitude)")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                                    .padding(.bottom, 2)
                                Text("Distance unknown")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .disabled(true)
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

struct Geocaches_Previews: PreviewProvider {
    static var previews: some View {
        Geocaches()
    }
}
