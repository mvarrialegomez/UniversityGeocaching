//
//  CacheStatusView.swift
//  UniversityGeocaching
//
//  Created by Maria Varriale Gomez on 4/17/24.
//

import SwiftUI

struct CacheStatusView: View {
    // Sample data
    var allCaches = [
        CacheStatus(title: "USD Torero Store", numClaimed: 3, users: "Maria Varriale Gomez, Natalie Nyugen, David Amano"),
        CacheStatus(title: "Student Life Pavilion", numClaimed: 1, users: "Michael Gallagher"),
        CacheStatus(title: "Warren Hall", numClaimed: 0, users: "None"),
        CacheStatus(title: "Copley Library", numClaimed: 5, users: "Maria Varriale Gomez, Natalie Nyugen, David Amano, Michael Gallagher, Sean Limqueco")
    ]
    
    struct CacheStatus: Identifiable {
        let title: String
        let numClaimed: Int
        let users: String
        let id = UUID()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                VStack {
                    Text("Cache Status")
                        .font(.system(size: 30))
                        .bold()
                    
            //        Text("Total caches completed: 3")
              //          .font(.title2)
                    //List(allCaches, id: \.title) { CacheStatus in

//                    List(allCaches) {
//                        VStack(alignment: .leading) {
//                            Text($0.title)
//                                .font(.headline)
//                            Text($0.numCompleted)
//                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                            Text($0.users)
//                                .font(.footnote)
//                                .foregroundColor(.gray)
//                        }
//                    }
                  
           //         List(allCaches, id: \.title) { CacheStatus in

                    List(allCaches) {
                        Text($0.title)
                        //Text($0.numCompleted)
                        //Text($0.users)
                    }
                    
                    
                    
                    
                    
                }.padding(.top, 50) // Add padding above "Past Quests" - END OF VSTACK
                
            }
        }
    }
}
  

#Preview {
    CacheStatusView()
}
