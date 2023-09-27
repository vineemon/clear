//
//  LoginView.swift
//  Clear
//
//  Created by Vineet Nadella on 9/12/23.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct LoginView: View {
    @EnvironmentObject var firestoreManager: FirestoreManager
    @State var email = ""
    @State var password = ""
    @State var isLoginActive = false
    
    var body: some View {
            VStack {
                Spacer()
                Button(action: loginGoogle) {
                    Text("Continue with Google").frame(maxWidth: .infinity) .foregroundColor(.black).bold()
                            .overlay(Image("GoogleIcon").resizable()
                                .frame(width: 30, height: 30).padding(10),
                                     alignment: .leading)
                }.frame(alignment: .center).background(alignment: .center, content: {
                    RadialGradient(
                        colors: [Color(.systemGray6), .white],
                                 center: .center,
                                 startRadius: 0,
                                 endRadius: 500)
                    .frame(width: 350, height: 60, alignment: .center)
                }
                ).frame(width: 350, height: 60, alignment: .center).cornerRadius(10).foregroundColor(.white)
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
                ContentView().environmentObject(firestoreManager).navigationBarBackButtonHidden(true)
        }
    }
    
    func login() {
        firestoreManager.login(email: email, password: password)
        self.isLoginActive = true
    }
    
    func loginGoogle() {
        firestoreManager.loginGoogle()
        self.isLoginActive = true
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(FirestoreManager())
    }
}
