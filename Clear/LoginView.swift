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
        NavigationStack {
            VStack {
                Spacer()
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                Button(action: login) {
                    Text("Sign In")
                }.buttonStyle(.borderedProminent)
                
                Spacer()
                NavigationLink("Sign Up for Chrono") {
                    RegistrationView().environmentObject(firestoreManager)
                    }
            }.padding().navigationDestination(isPresented: $isLoginActive) {
//                ContentView(cloudProjects: $firestoreManager.cloudProjects)
                ContentView(cloudProjects: [
                                    CloudProject(title: "Database",
                                                 progress: 0.0,
                                                 difficulty: "Medium",
                                               theme: .seafoam),
                                    CloudProject(title: "Load Balancer",
                                                 progress: 0.0,
                                                 difficulty: "Hard",
                                               theme: .poppy),
                                    CloudProject(title: "Caching",
                                                 progress: 0.0,
                                                 difficulty: "Hard",
                                               theme: .poppy)
                                ]).navigationBarHidden(true)
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
        LoginView()
    }
}
