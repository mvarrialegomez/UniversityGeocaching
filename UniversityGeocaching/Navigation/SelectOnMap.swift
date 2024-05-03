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
    var cachedata: Cache
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    @State private var CurrentCoordinate: CLLocationCoordinate2D?
    @StateObject private var locationManager = LocationManager()
    @State private var ConfirmationC = false
    @State private var ConfirmationS = false
    @Binding var isShowingMap: Bool
    
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
                                ConfirmationC = true
                            }) {
                                Text("Current Location")
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .font(.system(size: 15))
                            }
                            .alert(isPresented: $ConfirmationC){
                                Alert(title: Text("Create Cache at Current Location?"),
                                      message: Text("This action cannot be undone."),
                                      primaryButton: .default(Text("Yes")){
                                        let newcache = Cache(serial: "", name: cachedata.name, coordinate: CLLocationCoordinate2D(latitude: CurrentCoordinate?.latitude ?? 0, longitude: CurrentCoordinate?.longitude ?? 0), question: cachedata.question, correctAnswer: cachedata.correctAnswer, answer2: cachedata.answer2, answer3: cachedata.answer3, answer4: cachedata.answer4)
                                        WriteCache(NewCache: newcache)
                                        presentationMode.wrappedValue.dismiss()
                                        isShowingMap = false // Set the flag to switch to the other page
                                      },
                                      secondaryButton: .cancel(Text("No")))
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
                                ConfirmationS = true
                            }) {
                                Text("Selected Location")
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .font(.system(size: 15))
                            }
                            .alert(isPresented: $ConfirmationS){
                                Alert(title: Text("Create Cache at Selected Location?"),
                                      message: Text("This action cannot be undone."),
                                      primaryButton: .default(Text("Yes")){
                                        let newcache = Cache(serial: "", name: cachedata.name, coordinate: CLLocationCoordinate2D(latitude: selectedCoordinate?.latitude ?? 0, longitude: selectedCoordinate?.longitude ?? 0), question: cachedata.question, correctAnswer: cachedata.correctAnswer, answer2: cachedata.answer2, answer3: cachedata.answer3, answer4: cachedata.answer4)
                                        WriteCache(NewCache: newcache)
                                        presentationMode.wrappedValue.dismiss()
                                        isShowingMap = false // Set the flag to switch to the other page
                                      },
                                      secondaryButton: .cancel(Text("No")))
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

struct MainView: View {
    var cachedata: Cache
    @State private var isShowingMap = true
    
    var body: some View {
        ZStack {
            if isShowingMap {
                SelectOnMapView(cachedata: cachedata, isShowingMap: $isShowingMap)
            } else {
                OtherPageView()
            }
        }
    }
}

struct OtherPageView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            // Your other page content here
            Button("Go Back") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}


