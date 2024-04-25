
//  CreateQuestView.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 3/14/23.
//  Continued by Maria Varriale Gomez, David Amano, Natalie Nguyen, Michael Gallagher, and Sean Limqueco in Spring 2024.
//

import SwiftUI
import CoreLocation

struct CreateQuery: View {
    @State private var cacheName: String = ""
    @State private var Question1: String = ""
    @State private var Q1CorrectAnswer: String = ""
    @State private var Q1Answer1: String = ""
    @State private var Q1Answer2: String = ""
    @State private var Q1Answer3: String = ""
    @State private var Question2: String = ""
    @State private var Q2CorrectAnswer: String = ""
    @State private var Q2Answer1: String = ""
    @State private var Q2Answer2: String = ""
    @State private var Q2Answer3: String = ""
    @State private var Question3: String = ""
    @State private var Q3CorrectAnswer: String = ""
    @State private var Q3Answer1: String = ""
    @State private var Q3Answer2: String = ""
    @State private var Q3Answer3: String = ""

    private let manager = CLLocationManager()
    private var cacheCoordinates: String = "0.0, 0.0"

    func validate(cacheName: String) -> Bool {
        return true //accepts any value at the moment
    }

    func getCurrentCoordinates() -> String {
        manager.requestLocation()//uses the users current location
        //add in a function where they can input coordinates of their choosing
        return "0.0,0.0" //automatically returns these coordinates
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Create New Quest")
                .font(.largeTitle)
                .padding()

            List {
                Section(header: Text("Quest Details")) {
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
                    HStack {
                        Text("Question 2:")
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false){
                            TextField("Enter question", text: $Question2)
                        }
                    }
                    HStack {
                        Text("Correct Answer:").padding(.leading, 25)
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false){
                            TextField("Correct answer", text: $Q2CorrectAnswer)
                        }
                    }
                    HStack {
                        Text("Incorrect Answer:").padding(.leading, 25)
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false){
                            TextField("Incorrect answer", text: $Q2Answer1)
                        }
                    }
                    HStack {
                        Text("Incorrect Answer:").padding(.leading, 25)
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false){
                            TextField("Incorrect answer", text: $Q2Answer2)
                        }
                    }
                    HStack {
                        Text("Incorrect Answer:").padding(.leading, 25)
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false){
                            TextField("Incorrect answer", text: $Q2Answer3)
                        }
                    }
                    HStack {
                        Text("Question 3:")
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false){
                            TextField("Enter question", text: $Question3)
                        }
                    }
                    HStack {
                        Text("Correct Answer:").padding(.leading, 25)
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false){
                            TextField("Correct answer", text: $Q3CorrectAnswer)
                        }
                    }
                    HStack {
                        Text("Incorrect Answer:").padding(.leading, 25)
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false){
                            TextField("Incorrect answer", text: $Q3Answer1)
                        }
                    }
                    HStack {
                        Text("Incorrect Answer:").padding(.leading, 25)
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false){
                            TextField("Incorrect answer", text: $Q3Answer2)
                        }
                    }
                    HStack {
                        Text("Incorrect Answer:").padding(.leading, 25)
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false){
                            TextField("Incorrect answer", text: $Q3Answer3)
                        }
                    }
                }

                Section(header: Text("Location")) {
                    NavigationLink(destination: CreateLocation().navigationBarBackButtonHidden())
                    {
                        Text("Update Coordinates")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
            .listStyle(GroupedListStyle())

            Spacer()
        }
    }
}

struct CreateQuery_Previews: PreviewProvider {
    static var previews: some View {
        CreateQuestView()
    }
}
