//
//  AdminView.swift
//  UniversityGeocaching
//
//  Created by Maria Varriale Gomez on 4/3/24.
//

import SwiftUI

struct AdminView: View {
    var body: some View {
        
        Image("SignInScreenImage")
            .resizable()
        
        HStack(alignment: .bottom){
            NavigationLink(destination: CacheStatusView()){
                HStack{
                    Image(systemName: "checkmark.circle")
                    Text("Cache Status")
                }
                .frame(width: 150, height: 40)
                .padding()
                .foregroundColor(Color(red: 51/255, green: 98/255, blue: 164/255))
                .background(Color.white)
                .cornerRadius(15)
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color(red: 51/255, green: 98/255, blue: 164/255), lineWidth: 1))
            }
        }
        .padding(.vertical,10)
        
        HStack(alignment: .bottom){
            NavigationLink(destination: CreateQuestView()){
                HStack{
                    Image(systemName: "plus.circle")
                    Text("Create Cache")
                }
                .frame(width: 150, height: 40)
                .padding()
                .foregroundColor(Color(red: 51/255, green: 98/255, blue: 164/255))
                .background(Color.white)
                .cornerRadius(15)
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color(red: 51/255, green: 98/255, blue: 164/255), lineWidth: 1))
            }
        }
        .padding(.vertical,10)
        
        HStack(alignment: .bottom){
            NavigationLink(destination: ContentView()){
                HStack{
                    Image(systemName: "arrow.right.square")
                    Text("Home Page")
                }
                .frame(width: 150, height: 40)
                .padding()
                .foregroundColor(.white)
                .background(Color(red: 0/255, green: 116/255, blue: 200/255))
                .cornerRadius(15)
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color(red: 51/255, green: 98/255, blue: 164/255), lineWidth: 1))
            }
        }
        //.padding(.vertical,10)
    }
}

#Preview {
    AdminView()
}
