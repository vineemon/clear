//
//  MainView.swift
//  Clear
//
//  Created by Vineet Nadella on 9/25/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var firestoreManager: FirestoreManager
    var body: some View {
        NavigationStack {
            Group{
                if firestoreManager.user != nil {
                    ContentView(cloudProjects: []).environmentObject(firestoreManager)
                } else {LoginView().environmentObject(firestoreManager) }
            }.onAppear{
                firestoreManager.listenToAuthState()
            }
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}