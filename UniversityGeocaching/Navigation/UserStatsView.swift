//
//  UserStatsView.swift
//  UniversityGeocaching
//
//  Created by Maria Varriale Gomez on 4/12/24.
//

import SwiftUI

struct UserStatsView: View {
    @EnvironmentObject var userData: UserData
    
    // Sample data
    let pastQuests = [
        Quest(title: "Cache 1", location: "GYM", completionDate: "2024-03-01"),
        Quest(title: "Cache 2", location: "SLP", completionDate: "2024-02-15"),
        Quest(title: "Cache 3", location: "KNAUSS", completionDate: "2024-01-20"),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text(userData.userEmail)
                    .font(.system(size: 36))
                    .bold()
                    .padding()
                
                Text("User Stats")
                    .font(.system(size: 36))
                    .bold()
                    .padding()
                
                VStack(alignment: .leading) {
                    
                    Text("Name: John Smith")
                        .font(.title2)
                    
                    Text("Email: jsmith@sandiego.edu")
                        .font(.title2)
                    
                    } //VStack closing
                
                VStack {
                    Text("Past Caches")
                        .font(.system(size: 30))
                        .bold()
                    
                    Text("Total caches completed: 3")
                        .font(.title2)
                       
                    List(pastQuests, id: \.title) { quest in
                        VStack(alignment: .leading) {
                            Text(quest.title)
                                .font(.headline)
                            Text(quest.location)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text(quest.completionDate)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }.padding(.top, 50) // Add padding above "Past Quests" - END OF VSTACK
                
            }
        }
    }
}

struct Quest {
    let title: String
    let location: String
    let completionDate: String
}

#Preview {
    UserStatsView()
}
