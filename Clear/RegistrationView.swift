//
//  SignUpView.swift
//  Clear
//
//  Created by Vineet Nadella on 9/12/23.
//

import SwiftUI
import Firebase

struct RegistrationView: View {
    @EnvironmentObject var firestoreManager: FirestoreManager
    @State var email = ""
    @State var password = ""
    @State var isRegistrationActive = false
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading) {
                Text("Email").foregroundColor(.blue)
                TextField("Enter your email address", text: $email)
                Divider().overlay(.blue)
                Text("Password").foregroundColor(.blue)
                SecureField("Create your password", text: $password)
                Divider().overlay(.blue)
            }.padding()
            Button(action: register) {
                Text("Create Account").padding().frame(width: 200)
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
        }.padding().navigationTitle(Text("Register using Email Account")).navigationBarTitleDisplayMode(.inline).navigationDestination(isPresented: $isRegistrationActive) {
            LoginView().environmentObject(firestoreManager).navigationBarHidden(true)
        }
    }
        
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                self.isRegistrationActive = true
                print("success")
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView().environmentObject(FirestoreManager())
    }
}
