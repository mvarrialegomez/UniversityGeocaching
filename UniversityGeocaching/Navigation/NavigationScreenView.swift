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

struct Cache: Identifiable {
    var id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct NavigationScreenView: View {
    
    @StateObject private var locationManager = LocationManager()
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 32.772364, longitude: -117.187653),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )
    
    @State var showingUserLocation = false
    
    //for QR code scanner
    @State var isPresentingScanner = false
    @State var scannedCode: String = "Scan a QR code to get started."
    
    @State var isPresentingFinishPopUp = false
    
    func showFinishPopUp() {
        self.isPresentingFinishPopUp = true
    }
    
    //qr code scannersheet
    var scannerSheet: some View {
        CodeScannerView(
            codeTypes: [.qr],
            completion: { result in
                if case let .success(code) = result {
                    self.scannedCode = code.string
                    self.isPresentingScanner = false
                    if let url = URL(string: scannedCode), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                        // show the finish popup after successfully scanning the QR code
                        self.showFinishPopUp()
                    } else {
                        // Show an error or handle non-URL QR codes as needed
                    }
                }
            }
        )
    }
    
    
    var caches = [
        Cache(id: UUID(), name: "USD Torero Store", coordinate: CLLocationCoordinate2D(latitude: 32.772364, longitude: -117.187653)),
        Cache(id: UUID(), name: "Student Life Pavilion", coordinate: CLLocationCoordinate2D(latitude: 32.77244, longitude: -117.18727)),
        Cache(id: UUID(), name: "Warren Hall", coordinate: CLLocationCoordinate2D(latitude: 32.77154, longitude:  -117.18884)),
        Cache(id: UUID(), name: "Copley Library", coordinate: CLLocationCoordinate2D(latitude: 32.771443, longitude: -117.193472)),
    ]
    
    var body: some View {
        TabView {
            // Map tab
            ZStack { //ZStack open
                Map(coordinateRegion: $region, showsUserLocation: showingUserLocation, annotationItems: caches) {
                    
                    cache in MapAnnotation(coordinate: cache.coordinate) {
                        
                        Image("cachePin.fill")
                            .foregroundColor(.blue)
                            .foregroundStyle(.blue)
                            .imageScale(.large)
                        
                            // Prints name of cache on console on tap
                            .onTapGesture {
                                print(cache.name)
                            }
                    }
                    
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        // Button to show user's current location
                        Button(action: {
                            showingUserLocation = true
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
                    Image(systemName: "map")
                    Text("Map")
                }
            } // ZStack close
            
            .sheet(isPresented: $isPresentingFinishPopUp) {
                FinishPopUpView(isPresentingFinishPopUp: $isPresentingFinishPopUp)
            }
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
                 
struct FinishPopUpView: View {
    @Binding var isPresentingFinishPopUp: Bool

    var body: some View {
        VStack {
            Text("Quest Completed!")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.green)
                .padding()
            Text("Congratulations, you have finished the quest!")
                .multilineTextAlignment(.center)
                .padding()
            Button(action: {
                // Dismiss the pop-up
                dismiss()
            }) {
                Text("Close")
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
    }

    func dismiss() {
        isPresentingFinishPopUp = false
    }
}

struct DetailView: View {
    var body: some View {
        Text("Detail View")
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Detail Title")
    }
}

struct NavigationScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationScreenView()
    }
}
