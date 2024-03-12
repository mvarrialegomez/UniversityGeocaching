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
        NavigationView{
            VStack{
                Spacer(minLength: 200)
                ZStack(alignment: .leading) {
                    Image("Home Page 1")
                        .resizable()
                        .aspectRatio(UIImage(named: "Home Page 1")!.size, contentMode: .fill)
                        .padding(.bottom, 35)
                    
                    
                    /**
                     Text("University of San Diego")
                     .font(.system(size: 32, weight: .bold))
                     .frame(width: 450, height: 00)
                     .foregroundColor(Color(red: 51/255, green: 98/255, blue: 164/255))
                     .padding(.vertical, 0)
                     .padding(.horizontal, 100)
                     .multilineTextAlignment(.center)
                     Text(" Geocaching")
                     .font(.system(size: 40, weight: .bold))
                     .foregroundColor(Color(red: 0x5D/255, green: 0x96/255, blue: 0x7B/255))
                     .frame(width: 450, height: 00)
                     .padding(.vertical, 40)
                     .padding(.horizontal, 100)
                     .cornerRadius(40)
                     .multilineTextAlignment(.center)
                     Image("Home Page 1")
                     .resizable()
                     .frame(width: 350, height: 350)
                     .cornerRadius(40)
                     .padding(.vertical, 10)
                     .padding(.horizontal, 150)
                     Spacer()
                     */
                    
                    
                    VStack(){
                        HStack(alignment: .bottom){
                            NavigationLink(destination: PastQuestView()){
                                HStack{
                                    Image(systemName: "checkmark.circle")
                                    Text("Past Quests")
                                }
                                .frame(width: 150, height: 40)
                                .padding()
                                .foregroundColor(Color(red: 51/255, green: 98/255, blue: 164/255))
                                .background(Color.white)
                                .cornerRadius(15)
                                .overlay(RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color(red: 51/255, green: 98/255, blue: 164/255), lineWidth: 1))
                            }
                            
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
                                NavigationLink(destination: CreateQuestView()){
                                    HStack{
                                        Image(systemName: "checklist.unchecked")
                                        Text("New Quest")
                                    }
                                    .frame(width: 150, height: 40)
                                    .padding()
                                    .foregroundColor(Color(red: 51/255, green: 98/255, blue: 164/255))
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .overlay(RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color(red: 51/255, green: 98/255, blue: 164/255), lineWidth: 1))
                                }
                                
                                NavigationLink(destination: UserSettingsView()){
                                    HStack{
                                        Image(systemName: "person.2.badge.gearshape")
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
                    .padding(.top, 450)
                }
                
                .padding(.bottom, 200) // Add padding to the bottom of the screen
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


