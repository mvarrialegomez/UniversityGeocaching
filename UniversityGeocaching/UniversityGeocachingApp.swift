//
//  UniversityGeocachingApp.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 2/7/23.
//  Continued by Maria Varriale Gomez, David Amano, Natalie Nguyen, Michael Gallagher, and Sean Limqueco in Spring 2024.
//

import SwiftUI

class UserData: ObservableObject {
    @Published var userEmail: String = ""
}

@main
struct UniversityGeocachingApp: App {
    let userData = UserData()
    
    var body: some Scene {
        WindowGroup {
            SignIn()
                .environmentObject(userData)
        }
    }
}
