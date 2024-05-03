
//  CreateQuestView.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 3/14/23.
//  Continued by Maria Varriale Gomez, David Amano, Natalie Nguyen, Michael Gallagher, and Sean Limqueco in Spring 2024.
//

import SwiftUI
import CoreLocation

struct CreateCache: View {
    @State private var cacheName: String = ""
    @State private var Question1: String = ""
    @State private var Q1CorrectAnswer: String = ""
    @State private var Q1Answer1: String = ""
    @State private var Q1Answer2: String = ""
    @State private var Q1Answer3: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create New Cache")
                .font(.largeTitle)
                .padding()
                .bold()

            List {
                Section(header: Text("Cache Details")) {
                    HStack {
                        Text("Cache Name:")
                        Spacer()
                        TextField("Enter cache name", text: $cacheName)
                    }
                    HStack {
                        Text("Question 1:")
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false){
                            TextField("Enter question", text: $Question1)
                        }
                    }
                    HStack {
                        Text("Correct Answer:").padding(.leading, 25)
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false){
                            TextField("Correct answer", text: $Q1CorrectAnswer)
                        }
                    }
                    HStack {
                        Text("Incorrect Answer:").padding(.leading, 25)
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false){
                            TextField("Incorrect answer", text: $Q1Answer1)
                        }
                    }
                    HStack {
                        Text("Incorrect Answer:").padding(.leading, 25)
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false){
                            TextField("Incorrect answer", text: $Q1Answer2)
                        }
                    }
                    HStack {
                        Text("Incorrect Answer:").padding(.leading, 25)
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false){
                            TextField("Incorrect answer", text: $Q1Answer3)
                        }
                    }
                }

                Section(header: Text("Location")) {
                    NavigationLink(destination: SelectOnMapView(cachedata: Cache(serial: "", name: cacheName, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), question: Question1, correctAnswer: Q1CorrectAnswer, answer2: Q1Answer1, answer3: Q1Answer2, answer4: Q1Answer3)))
                    {
                        Text("Set Location")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                /* Add if you have time, must impliment image upload code
                Section(header: Text("Image")) {
                    
                }
                 */
            }
            .listStyle(GroupedListStyle())

            Spacer()
        }
    }
}

struct CreateQuery_Previews: PreviewProvider {
    static var previews: some View {
        Geocaches()
    }
}
