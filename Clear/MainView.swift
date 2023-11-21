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
        Group {
            if firestoreManager.user != nil {
                ContentView()
            } else {
                LoginView()
            }
        }
        .onAppear(){
            firestoreManager.listenToAuthState()
        }
    }
}
