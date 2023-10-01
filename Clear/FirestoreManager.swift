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
                    self.cloudProjects = try document!.data(as: CloudProjects.self).cloudProjects
                } catch {
                    print("Error occurred when reading database!!")
                }
            }
        }
    }
    
    
    
    func save() {
        let docRef = Firestore.firestore().collection("CloudProjects").document(user!.uid)
        do {
            try docRef.setData(from: CloudProjects(documentId: user!.uid, cloudProjects: self.cloudProjects))
        }
        catch {
          print(error)
        }
    }
    
    //TODO: create a method for updating individual records. Rather than re-writing the entire list each time.
    
    func upload(image: UIImage) -> String {
        let storage = Storage.storage()
        // Create a storage reference\
        let path = "images/\(UUID().uuidString).jpg"
        let storageRef = storage.reference().child(path)
        //
        //        // Resize the image to 200px with a custom extension
        //        let resizedImage = image..aspectFittedToHeight(200)
        
        // Convert the image into JPEG and compress the quality to reduce its size
        let data = image.jpegData(compressionQuality: 0.2)
        
        // Upload the file to the path "images/rivers.jpg"
        _ = storageRef.putData(data!, metadata: nil) { (metadata, error) in
            if error != nil && metadata == nil {
                // Uh-oh, an error occurred!
                return
            }
        }
        return path
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

struct CloudProjects: Codable {
  @DocumentID var documentId: String?
  var cloudProjects: [CloudProject]
}
