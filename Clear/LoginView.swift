//
//  LoginView.swift
//  Clear
//
//  Created by Vineet Nadella on 9/12/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @EnvironmentObject var firestoreManager: FirestoreManager
    @State var email = ""
    @State var password = ""
    @State var isLoginActive = false
    
    var body: some View {
            VStack {
                Spacer()
                VStack(alignment: .leading) {
                    Text("Email").foregroundColor(.blue)
                    TextField("Enter your email address", text: $email)
                    Divider().overlay(.blue)
                    Text("Password").foregroundColor(.blue)
                    SecureField("Enter your password", text: $password)
                    Divider().overlay(.blue)
                }.padding()
                Button(action: login) {
                    Text("Sign In").padding().frame(width: 200)
                }.frame(alignment: .center).background(alignment: .center, content: {
                    RadialGradient(
                        colors: [.blue, .white],
                                 center: .center,
                                 startRadius: 0,
                                 endRadius: 500)
                    .frame(width: 200, height: 80, alignment: .center)
                }
                ).frame(width: 200, height: 80, alignment: .center).cornerRadius(50).foregroundColor(.white)
                Spacer()
                NavigationLink("Sign Up for Clear") {
                    RegistrationView().environmentObject(firestoreManager)
                    }
            }.padding().navigationDestination(isPresented: $isLoginActive) {
//                ContentView(cloudProjects: $firestoreManager.cloudProjects)
                ContentView(cloudProjects: []).environmentObject(firestoreManager).navigationBarBackButtonHidden(true)
                    .onAppear {
                        Task {
                            if (Auth.auth().currentUser != nil) {
                                print("User .. \(Auth.auth().currentUser?.displayName)")
                                ContentView(cloudProjects: [])
                            }
                        }
                    }
        }
    }
        
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                self.isLoginActive = true
                print("success")
                firestoreManager.fetchEvents(username: email)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(FirestoreManager())
    }
}
