//
//  FirestoreManager.swift
//  ChronoService
//
//  Created by Vineet Nadella on 9/12/23.
//

import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import PhotosUI
import SwiftUI
import GoogleSignIn

class FirestoreManager: ObservableObject {
    @Published var cloudProjects: [CloudProject] = []
    var user: User? {
        didSet {
            objectWillChange.send()
        }
    }
    //    @Published var images: [[EventPic]] = [[]]
    
    func fetchEvents(username: String) {
        let db = Firestore.firestore()
        let storage = Storage.storage()
        let docRef = db.collection("CloudCourses").document(username.lowercased())
        
        docRef.getDocument { document, error in
            if error == nil && document != nil {
                do {
                    //                    self.timelines = try document!.data(as: Timelines.self).timelines
                    //                    for i in 0..<self.timelines.count {
                    //                        self.images.insert([], at: i)
                    //                        for j in 0..<self.timelines[i].events.count  {
                    ////                            self.images[i].insert(EventPic(), at: j)
                    //                            // Create a reference to the file you want to download
                    //                            let storageRef = storage.reference().child(self.timelines[i].events[j].imageUrl)
                    //                            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                    //                            storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    //                                if error != nil && data == nil {
                    //                                    print("Error occurred when reading storage!!")
                    //                                } else {
                    //                                    // Data for image is returned
                    //                                    self.images[i][j].eventImage = UIImage(data: data!)
                    //                                }
                    //                            }
                    //                        }
                    //                    }
                } catch {
                    print("Error occurred when reading database!!")
                }
            }
        }
    }
    
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
            self.user = user
        }
    }
    
    
    func signOut() {
        do {
            try Auth.auth().signOut()
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
                    //                    firestoreManager.fetchEvents(username: email)
                }
            }
        }
    }
}
