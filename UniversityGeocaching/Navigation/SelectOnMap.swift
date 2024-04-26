import SwiftUI
import MapKit
import CoreLocation

struct SelectOnMap: UIViewRepresentable{
    @Binding var selectedCoordinate: CLLocationCoordinate2D?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 32.771936, longitude: -117.188939),
            span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015))
        let gestureRecognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        mapView.addGestureRecognizer(gestureRecognizer)
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context){ //updates map on gesture
        if let coordinate = selectedCoordinate {
            //removes previous pin
            mapView.removeAnnotations(mapView.annotations)
            //adds new pin
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: SelectOnMap
        
        init(_ parent: SelectOnMap) {
            self.parent = parent
        }
        
        @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
            guard let mapView = gestureRecognizer.view as? MKMapView else { return }
            let location = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
            parent.selectedCoordinate = coordinate
        }
    }
}

struct SelectOnMapView: View {
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    @State private var CurrentCoordinate: CLLocationCoordinate2D?
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        ZStack{
            SelectOnMap(selectedCoordinate: $selectedCoordinate)
                .edgesIgnoringSafeArea(.all)
            VStack{
                //Text("Selected Coordinate: \(selectedCoordinate?.latitude ?? 0), \(selectedCoordinate?.longitude ?? 0)")
                Spacer()
                HStack {
                    // Button to show user's current location
                    HStack{
                        Button(action: {
                            locationManager.requestLocation()
                            print("Current Coordinate: \(CurrentCoordinate?.latitude ?? 0), \(CurrentCoordinate?.longitude ?? 0)")
                        }) {
                            Text("Current Location")
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .font(.system(size: 15))
                        }
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity) // how to make a button fill all the space available horizontally
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding()
                    HStack{
                        Button(action: {
                            print("Selected Coordinate: \(selectedCoordinate?.latitude ?? 0), \(selectedCoordinate?.longitude ?? 0)")
                        }) {
                            Text("Selected Location")
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .font(.system(size: 15))
                        }
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity) // how to make a button fill all the space available horizontally
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding()
                    
                    
                    
                }
            }
        }
        .onAppear {
            locationManager.requestLocation()
        }
        .onReceive(locationManager.$location) { location in
            if let location = location {
                CurrentCoordinate = location.coordinate
            }
        }
    } // ZStack close
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


