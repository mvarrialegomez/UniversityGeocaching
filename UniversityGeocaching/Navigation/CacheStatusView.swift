//
//  CacheStatusView.swift
//  UniversityGeocaching
//
//  Created by Maria Varriale Gomez on 4/17/24.
//

import SwiftUI

struct CacheStatusView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Cache Status")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 30)
                    .padding(.bottom, 10)
                
                ScrollView {
                    VStack(spacing: 10) {
                        if let allCaches = readCacheCSV() {
                            ForEach(allCaches.indices, id: \.self) { cacheIndex in
                                let cache = allCaches[cacheIndex]
                                DisclosureGroup(content: {
                                    let usersCompleted = getCacheStatus(cacheID: cache.serial)
                                    ForEach(usersCompleted, id: \.self) { user in
                                        HStack(spacing: 10) {
                                            Image(systemName: "person.circle.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(.blue)
                                            Text(user)
                                                .font(.body)
                                                .foregroundColor(.primary)
                                        }
                                        .padding(.vertical, 4)
                                    }
                                }, label: {
                                    Text(cache.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                })
                                .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                .padding(.vertical, 4)
                                .background(Color.secondary.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct CacheStatusView_Previews: PreviewProvider {
    static var previews: some View {
        CacheStatusView()
    }
}
