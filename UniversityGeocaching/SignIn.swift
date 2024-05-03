//
//  SignIn.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 2/21/23.
//  Continued by Maria Varriale Gomez, David Amano, Natalie Nguyen, Michael Gallagher, and Sean Limqueco in Spring 2024.
//
import SwiftUI

struct User: Identifiable {
    var id = UUID()
    var Email: String
    var Password: String
    var Access: String
    var Name: String
}

struct LogOutButton: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack{
                Text("Log Out")
            }
        }
    }
}

struct SignIn: View {
    
    @State var name: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    @State var isSignedIn: Bool = false
    @State var showAlert: Bool = false
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 15) {
                
                Image("SignInScreenImage")
                    .resizable()
                
                Spacer()
                
                TextField("Name",
                          text: $name ,
                          prompt: Text("Login").foregroundColor(.blue)
                )
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                }
                .padding(.horizontal)
                
                HStack {
                    Group {
                        if showPassword {
                            TextField("Password",
                                      text: $password,
                                      prompt: Text("Password").foregroundColor(.blue))
                        } else {
                            SecureField("Password",
                                        text: $password,
                                        prompt: Text("Password").foregroundColor(.blue))
                        }
                    }
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 2)
                    }
                    
                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye" : "eye.slash")
                            .foregroundColor(.blue)
                    }
                    
                }.padding(.horizontal)
                
                Spacer()
                
                VStack{
                    HStack{
                        NavigationLink(destination: ContentView().navigationBarBackButtonHidden()
                            .navigationBarItems(leading: LogOutButton().foregroundColor(.white)), isActive: $isSignedIn) {
                            EmptyView()
                        }
                        
                        Button(action: {
                            let verified = VerifyUser(email: name, password: password, access: false)
                            if verified {
                                print("verified")
                                userData.userEmail = name // Save the email to the environment object
                                isSignedIn = true
                            }
                            else {
                                showAlert = true
                            }
                        }){
                            HStack{
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.white)
                                Text("Sign In")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(20)
                            .padding()
                        }
                        
                        NavigationLink(destination: AdminView().navigationBarBackButtonHidden()
                            .navigationBarItems(leading: LogOutButton())){
                            HStack{
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.white)
                                Text("Admin")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(20)
                            .padding()
                        }
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Incorrect Credentials"), message: Text("Email or password is incorrect. Please try again."), dismissButton: .default(Text("OK")))
            }
        }
    }
}

            
//            NavigationLink(destination: ContentView()){
//                HStack{
//                    Text("Sign In")
//                        .font(.title2)
//                        .bold()
//                        .foregroundColor(.white)
//                }
//                .frame(height: 50)
//                .frame(maxWidth: .infinity) // how to make a button fill all the space available horizontaly
//                .background(
//                    isSignInButtonDisabled ? // how to add a gradient to a button in SwiftUI if the button is disabled
//                    LinearGradient(colors: [.gray], startPoint: .topLeading, endPoint: .bottomTrailing) :
//                        LinearGradient(colors: [.blue, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
//                )
//                .cornerRadius(20)
//                .disabled(isSignInButtonDisabled) // how to disable while some condition is applied
//                .padding()
//            }
        

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
