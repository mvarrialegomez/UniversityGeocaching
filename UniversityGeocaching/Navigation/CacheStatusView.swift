//
//  CacheStatusView.swift
//  UniversityGeocaching
//
//  Created by Maria Varriale Gomez on 4/17/24.
//

import SwiftUI

struct CacheStatusView: View {
    // Sample data
    var body: some View {
        NavigationView {
            VStack {
                Text("Cache Status")
                    .font(.system(size: 30))
                    .bold()
                
                Spacer()
            
                List {
                    Section {
                        DisclosureGroup("USD Torero Store (3)") {
                            HStack(spacing: 3) {
                                Label("Maria Varriale Gomez", systemImage: "person.circle.fill")
                            }
                            HStack(spacing: 3) {
                                Label("Natalie Nyugen", systemImage: "person.circle.fill")
                            }
                            HStack(spacing: 3) {
                                Label("David Amano", systemImage: "person.circle.fill")
                            }
                        }
                    }
                    Section {
                        DisclosureGroup("Student Life Pavilion (1)") {
                            HStack(spacing: 3) {
                                Label("Michael Gallagher", systemImage: "person.circle.fill")
                            }
                        }
                    }
                    Section {
                        DisclosureGroup("Warren Hall") {
                            HStack(spacing: 3) {
                                Label("None", systemImage: "person.fill.xmark")
                            }
                        }
                    }
                    Section {
                        DisclosureGroup("Copley Library (5)") {
                            HStack(spacing: 3) {
                                Label("Maria Varriale Gomez", systemImage: "person.circle.fill")
                            }
                            HStack(spacing: 3) {
                                Label("Natalie Nyugen", systemImage: "person.circle.fill")
                            }
                            HStack(spacing: 3) {
                                Label("David Amano", systemImage: "person.circle.fill")
                            }
                            HStack(spacing: 3) {
                                Label("Michael Gallagher", systemImage: "person.circle.fill")
                            }
                            HStack(spacing: 3) {
                                Label("Sean Limqueco", systemImage: "person.circle.fill")
                            }
                        }
                    }
                    
                }

            }
        }
    }
}
  

#Preview {
    CacheStatusView()
}
