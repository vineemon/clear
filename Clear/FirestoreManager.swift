//
//  FirestoreManager.swift
//  ChronoService
//
//  Created by Vineet Nadella on 9/12/23.
//

import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import SwiftUI
import GoogleSignIn

class FirestoreManager: ObservableObject {
    @Published var cloudProjects: [CloudProject] = []
    var user: User? {
        didSet {
            objectWillChange.send()
        }
    }
    
    func fetch() {
        let docRef = Firestore.firestore().collection("CloudProjects").document(user!.uid)
        docRef.getDocument { document, error in
            if error == nil && document != nil {
                do {
                    let cloudProjectsMap = try document!.data(as: [String: CloudProject].self)
                    let cloudProjectsSortedArray = cloudProjectsMap.sorted(by: { $0.0 < $1.0 })
                    cloudProjectsSortedArray.forEach({ key, value in
                        self.cloudProjects.append(value)
                    })
                } catch {
                    print("Error occurred when reading database!!")
                }
            }
        }
    }
    
    func saveItem(cloudProject: CloudProject) {
        let docRef = Firestore.firestore().collection("CloudProjects").document(user!.uid)
        do {
            var cloudProjectCoded = try Firestore.Encoder().encode(cloudProject)
            docRef.setData([cloudProject.title: cloudProjectCoded], merge: true)
        } catch {
            print("Error occurred when encoding object!!")
        }
    }
    
    func deleteItem(cloudProject: CloudProject) {
        let docRef = Firestore.firestore().collection("CloudProjects").document(user!.uid)
        docRef.updateData([cloudProject.title: FieldValue.delete()]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else {
                return
            }
            if (user == nil) {
                return
            }
            self.user = user
            self.fetch()
        }
    }
    
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
                self.fetch()
            }
        }
    }
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    func loginGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // 4
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [unowned self] user, error in
            guard error == nil else {
                return
            }
            
            guard let user = user?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { (result, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                } else {
                    print("success")
                    self.fetch()
                }
            }
        }
    }
}
