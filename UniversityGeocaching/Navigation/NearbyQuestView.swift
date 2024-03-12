//  NearbyQuestView.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 3/14/23.
//  Continued by Maria Varriale Gomez, David Amano, Natalie Nguyen, Michael Gallagher, and Sean Limqueco in Spring 2024.
//
import SwiftUI
import Combine
import Foundation
import CoreLocation
import MapKit

struct NearbyQuestView: View {
    @State private var nearbyQuests: [CreatedQuest] = []
    @StateObject private var cancellables = Cancellables() //subscriptions to publishers; prevents memory leaks and resource consumption
    @StateObject private var locationManager = LocationManager()

    var body: some View {
            NavigationView {
                VStack {
                    Text("Nearby Quests")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                        .padding(.bottom, 10)

                    List(nearbyQuests, id: \.id) { quest in
                        NavigationLink(destination: QuestMapView(quest: quest)) {
                            HStack {
                                Text(quest.cachename)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
                .navigationBarHidden(true)
                .onAppear(perform: loadData) //Load nearby quests when view appears
            }
        }


    func loadData() {
        /**
         * Prints out received requests sorted by distance
        */
        fetchQuests()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Fetching quests completed successfully")
                case .failure(let error):
                    print("Error fetching quests: \(error)")
                }
            }, receiveValue: { quests in
                print("Received quests: \(quests)")
                DispatchQueue.main.async {
                    self.nearbyQuests = self.sortQuestsByDistance(quests)
                }
            })
            .store(in: &cancellables.storage)
    }

    func fetchQuests() -> AnyPublisher<[CreatedQuest], Error> {
        /**
         * Fetches quests from the specified web API
         * @return A publisher with an array of `CreatedQuest` objects, or an error if the request fails.
        */
        let url = URL(string: "http://universitygeocaching.azurewebsites.net/api/location")!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("*/*", forHTTPHeaderField: "accept")
        request.setValue("starterKey420", forHTTPHeaderField: "X-Auth")

        return URLSession.shared.dataTaskPublisher(for: request)
        //Publishes a tuple that contains the fetched data and a URLResponse, if the task succeeds. An error, if the task fails.
            .tryMap { (data, response) -> Data in
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status code: \(httpResponse.statusCode)")
                    print("Response data: \(String(data: data, encoding: .utf8) ?? "Unable to decode response")")

                    if httpResponse.statusCode != 200 {
                        throw URLError(.badServerResponse)
                    }
                }
                return data
            }
            //handling asynchronous data processing
            .decode(type: [CreatedQuest].self, decoder: JSONDecoder()) //transforms the JSON response data into an array of CreatedQuest objects
            .receive(on: DispatchQueue.main) //ensures further operation are on the main thread
            .eraseToAnyPublisher() //makes the type more generic
    }

    func sortQuestsByDistance(_ quests: [CreatedQuest]) -> [CreatedQuest] {
        /**
         * Sorts an array of `CreatedQuest` objects based on their distance from the user's current location.
         * @parameters An array of 'CreatedQuest' objects to be sorted
         * @return An array of sorted 'CreatedQuest' objects
        */
        //checks if user's current location is available
        guard let userLocation = locationManager.lastKnownLocation else {
            return quests //if user location not available, return unsorted array
        }

        // Create CLLocation objects for quests for comparison
        return quests.sorted { quest1, quest2 in
            let quest1Location = CLLocation(latitude: quest1.latitude, longitude: quest1.longitude)
            let quest2Location = CLLocation(latitude: quest2.latitude, longitude: quest2.longitude)
            //compares distance of quest from user's location
            return userLocation.distance(from: quest1Location) < userLocation.distance(from: quest2Location)
        }
    }
}

class Cancellables: ObservableObject {
    var storage = Set<AnyCancellable>() //Subscriptions are cancelled when they are inactive or no longer necessary.
}

struct CreatedQuest: Identifiable, Codable {
    let id: Int
    let cachename: String
    let latitude: Double
    let longitude: Double

    let verificationString: String
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var lastKnownLocation: CLLocation? // Published property to store the user's current location

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            lastKnownLocation = location //updates lastKnownLocation
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error)")
    }
}



struct QuestMapView: View {
    /**
     * Represents a view that displays a map with a pin indicating the location of a quest.
     */
    var quest: CreatedQuest
    @State private var region: MKCoordinateRegion
    
    init(quest: CreatedQuest) {
        self.quest = quest
        // Specific coordinate region set around the created quests location
        self._region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: quest.latitude, longitude: quest.longitude), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)))
    }
    
    var body: some View {
        // Displays a map with a pin annotation indicating the location of the quest.
        Map(coordinateRegion: $region, annotationItems: [quest]) { quest in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: quest.latitude, longitude: quest.longitude)) {
                Image(systemName: "mappin.circle")
                    .resizable()
                    .foregroundColor(.red)
                    .frame(width: 40, height: 40)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle(Text(quest.cachename), displayMode: .inline)
    }
}

struct QuestMapView_Previews: PreviewProvider {
    static var previews: some View {
        QuestMapView(quest: CreatedQuest(id: 0, cachename: "Sample Cache", latitude: 37.7749, longitude: -122.4194, verificationString:"1234"))
    }
}



struct NearbyQuestView_Previews: PreviewProvider {
    static var previews: some View {
        NearbyQuestView()
    }
}



