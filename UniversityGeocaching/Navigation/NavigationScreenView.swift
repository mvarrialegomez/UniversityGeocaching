//  NavigationScreenView.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 3/14/23.
//  Continued by Maria Varriale Gomez, David Amano, Natalie Nguyen, Michael Gallagher, and Sean Limqueco in Spring 2024.
//


import Foundation
import MapKit
import SwiftUI
import CoreLocation
import SystemConfiguration.CaptiveNetwork

struct Cache: Identifiable {
    var id = UUID()
    var serial: String
    var name: String
    var coordinate: CLLocationCoordinate2D
    var question: String
    var correctAnswer: String
    var answer2: String
    var answer3: String
    var answer4: String
}

struct NavigationScreenView: View {
    @EnvironmentObject var userData: UserData
    @StateObject private var locationManager = LocationManager()
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 32.772364, longitude: -117.187653),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )
    
    @State var showingUserLocation = true
    
    // Replace caches list with @State variable
    @State var caches = readCacheCSV()
    
    @State var selectedCache: Cache? = nil
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            TabView {
                // Map tab
                ZStack {
                    Map(coordinateRegion: $region, showsUserLocation: showingUserLocation, annotationItems: caches!) { cache in
                        
                            MapAnnotation(coordinate: cache.coordinate) {
                                Image("cachePin.fill")
                                    .foregroundColor(.blue)
                                    .imageScale(.large)
                                    .onTapGesture {
                                        if let userLocation = locationManager.location, userLocation.distance(from: CLLocation(latitude: cache.coordinate.latitude, longitude: cache.coordinate.longitude)) <= 100 {
                                            selectedCache = cache
                                        } else {
                                            showAlert = true
                                        }
                                    }
                            }
                    }
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            // Button to show user's current location
                            Button(action: {
                                locationManager.requestLocation()
                                if let bssid = getBSSID() {
                                    print("BSSID: \(bssid)")
                                }
                                else{
                                    print("Not Connected to a WI-FI Network")
                                }
                            }) {
                                Image(systemName: "location.circle.fill")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 35))
                                    .padding(.top, 10)
                                    .padding(.leading, 20)
                                    .padding(.bottom, 80)
                                    .padding(.trailing, 40)
                                    .font(.system(size: 32))
                            }
                        }
                    }
                }
                .onAppear {
                    locationManager.requestLocation()
                }
                .onReceive(locationManager.$location) { location in
                    if let location = location {
                        region = MKCoordinateRegion(
                            center: location.coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
                        )
                        print(location.coordinate)
                    }
                }
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
            }
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("Map")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $selectedCache) { cache in
                CacheQuestionsPageView(cacheSerial: cache.serial, cacheName: cache.name, question: cache.question, correctAnswer: cache.correctAnswer, answer2: cache.answer2, answer3: cache.answer3, answer4: cache.answer4)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("You're Too Far!").foregroundColor(.red), message: Text("Get within 100m of the cache."), dismissButton: .default(Text("OK")))
                        }
        }
    }
    
    func getBSSID() -> String? {
        guard let interfaces = CNCopySupportedInterfaces() as? [String] else {
            return nil
        }
        for interface in interfaces {
            guard let info = CNCopyCurrentNetworkInfo(interface as CFString) as NSDictionary? else{
                continue
            }
            if let bssid = info[kCNNetworkInfoKeyBSSID as String] as? String{
                return bssid
            }
        }
        return nil
    }
    
    
    class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
        private let locationManager = CLLocationManager()
        @Published var location: CLLocation?
        
        override init() {
            super.init()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
        func requestLocation() {
            locationManager.requestWhenInUseAuthorization()
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
                 
struct DetailView: View {
    var body: some View {
        Text("Detail View")
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Detail Title")
    }
}

