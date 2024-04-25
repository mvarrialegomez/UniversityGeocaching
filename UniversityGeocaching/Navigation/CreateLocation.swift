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
import CodeScanner


struct CreateLocation: View {
    
    @StateObject private var locationManager = LocationManager()
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 32.772364, longitude: -117.187653),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )
    
    @State var showingUserLocation = true
    
    
    var body: some View {
        TabView {
            // Map tab
            ZStack { //ZStack open
                Map(coordinateRegion: $region, showsUserLocation: showingUserLocation)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        // Button to show user's current location
                        Button(action: {
                            locationManager.requestLocation()
                        }) {
                            Image(systemName: "location.circle.fill")
                                .foregroundColor(.blue)
                                .font(.system(size: 32))
                                .foregroundColor(.blue)
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
                            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                        )
                    }
                }
                .tabItem {
                    Button(action: {
                        locationManager.requestLocation()
                        print("Fuck you")
                    }) {
                        Text("Current Location")
                    }
                }
            } // ZStack close
            .edgesIgnoringSafeArea(.all)
            
            
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
    } //end of Navigation Screen View struct

