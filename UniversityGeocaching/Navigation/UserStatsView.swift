//
//  UserStatsView.swift
//  UniversityGeocaching
//
//  Created by Maria Varriale Gomez on 4/12/24.
//

import SwiftUI

struct UserStatsView: View {
    @EnvironmentObject var userData: UserData

    var body: some View {
        NavigationView {
            VStack {
                let pastQuests = getUserStats(email: userData.userEmail)
                
                Text("User Stats")
                    .font(.system(size: 36))
                    .bold()
                    .padding()

                VStack(alignment: .leading) {
                    Text("Name: \(returnUserName(email:userData.userEmail))")
                        .font(.title2)
                    
                    Text("Email: \(userData.userEmail)")
                        .font(.title2)

                    } //VStack closing

                VStack {
                    Text("Completed Quests")
                        .font(.system(size: 30))
                        .bold()

                    Text("Total quests completed: \(pastQuests.count)")
                        .font(.title2)

                    List {
                        ForEach(pastQuests) { cache in
                            VStack(alignment: .leading) {
                                Text(cache.name)
                                    .font(.headline)
                                Text("Latitude: \(cache.coordinate.latitude), Longitude: \(cache.coordinate.longitude)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }.padding(.top, 50) // Add padding above "Past Quests" - END OF VSTACK

            }
        }
    }
}

#Preview {
    UserStatsView()
}
