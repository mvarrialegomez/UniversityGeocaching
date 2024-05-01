//
//  UserStatsView.swift
//  UniversityGeocaching
//
//  Created by Maria Varriale Gomez on 4/12/24.
//

import SwiftUI

struct UserStatsView: View {
    @EnvironmentObject var userData: UserData
    
    // Get the specific user data object
    let userDataList = readUserDataFromCSV()
    
    // Get the list of all caches
    let allCaches = readCacheCSV()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("Email: \(userData.userEmail)")
                        .font(.system(size: 20))
                        .bold()
                        .padding(.top, 5)
                }
                .padding(.horizontal)
                
                VStack {
                    // Find the user data object with matching email
                    if let user = userDataList.first(where: { $0.userEmail == userData.userEmail }) {
                        // Filter the caches based on user's accessed caches
                        let completedCaches = allCaches?.filter { cache in
                            user.userCaches.contains { cacheInfo in
                                cacheInfo.0 == cache.serial && cacheInfo.1
                            }
                        } ?? []
                        
                        Text("Total caches completed: \(completedCaches.count)")
                            .font(.system(size: 20))
                            .bold()
                            .padding(.top, 5)
                        
                        List(completedCaches, id: \.id) { cache in
                            VStack(alignment: .leading) {
                                Text(cache.name)
                                    .font(.headline)
                            }
                        }
                    } else {
                        Text("User data not found.")
                            .font(.system(size: 20))
                            .bold()
                            .padding(.top, 5)
                    }
                }
                .padding(.horizontal)
                .navigationBarTitle("User Stats")
            }
        }
    }
}

struct UserStatsView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatsView()
            .environmentObject(UserData()) // Provide a sample UserData object
    }
}

