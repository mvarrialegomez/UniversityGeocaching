//
//  ContentView.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 2/21/23.
//  Continued by Maria Varriale Gomez, David Amano, Natalie Nguyen, Michael Gallagher, and Sean Limqueco in Spring 2024.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            Image("Home Page 3")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(UIImage(named: "Home Page 3")!.size, contentMode: .fill)
                    
                    VStack(){
                        Spacer()
                        HStack(alignment: .bottom){
                            NavigationLink(destination: UserStatsView()){
                                HStack{
                                    Image(systemName: "person.fill")
                                    Text("User Stats")
                                }
                                .frame(width: 150, height: 40)
                                .padding()
                                .foregroundColor(Color(red: 51/255, green: 98/255, blue: 164/255))
                                .background(Color.white)
                                .cornerRadius(15)
                                .overlay(RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color(red: 51/255, green: 98/255, blue: 164/255), lineWidth: 1))
                            }
                            .padding(.horizontal,10)
                            
                            NavigationLink(destination: NavigationScreenView()){
                                HStack{
                                    Image(systemName: "mappin.circle")
                                    Text("Navigation")
                                }
                                .frame(width: 150, height: 40)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color(red: 0/255, green: 116/255, blue: 200/255))
                                .cornerRadius(15)
                                .overlay(RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white, lineWidth: 1))
                                
                            }
                            
                        }
                        .padding(.bottom,5)

                        
                        
                        VStack{
                            HStack(alignment: .bottom){
                                NavigationLink(destination: Geocaches()){
                                    HStack{
                                        Image(systemName: "checklist.unchecked")
                                        Text("Geocaches")
                                    }
                                    .frame(width: 150, height: 40)
                                    .padding()
                                    .foregroundColor(Color(red: 51/255, green: 98/255, blue: 164/255))
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .overlay(RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color(red: 51/255, green: 98/255, blue: 164/255), lineWidth: 1))
                                }
                                .padding(.horizontal,10)
                                
                                NavigationLink(destination: UserSettingsView()){
                                    HStack{
                                        Image(systemName: "gearshape.fill")
                                        Text("Settings")
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
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 150) // Add padding to the bottom of the screen
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


