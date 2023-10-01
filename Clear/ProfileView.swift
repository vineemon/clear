//
//  ProfileView.swift
//  Clear
//
//  Created by Nadella, Vineet on 9/29/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var firestoreManager: FirestoreManager
    @State var isSettingsActive = false
    @State var addCoursesOpen = false
    @State var isHomeOpen = false
    @State var isLoggedOut = false
    @State var isProfileOpen = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
            }.padding().toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                        Button {
                            self.isSettingsActive = true
                        } label: {
                            Image(systemName: "gearshape.fill").foregroundColor(.black)
                        }
                }
            }
        }.toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Spacer()
                Button {
                    self.isHomeOpen = true
                } label: {
                    VStack{
                        Image(systemName:"house.fill").foregroundColor(.black)
                        Text("Courses").font(.footnote).foregroundColor(.black)
                    }
                }
                Spacer()
                Button {
                    self.addCoursesOpen = true
                } label: {
                    Image(systemName: "plus.app").foregroundColor(.black)
                }
                Spacer()
                Button {
                } label: {
                    VStack{
                        Image(systemName:"person.fill").foregroundColor(.black)
                        Text("Profile").font(.footnote).foregroundColor(.black)
                    }
                }
                Spacer()
            }
            
            ToolbarItemGroup(placement: .principal) {
                Text("Profile Settings").font(.title).bold()
            }
        }.navigationDestination(isPresented: $addCoursesOpen, destination: {
            AddCoursesView().environmentObject(firestoreManager).navigationBarBackButtonHidden(true)
        }).navigationDestination(isPresented: $isSettingsActive, destination: {
            SettingsView()
        }).navigationDestination(isPresented: $isHomeOpen, destination: {
            ContentView().environmentObject(firestoreManager).navigationBarBackButtonHidden(true)
        })
    }
}

#Preview {
    ProfileView()
}
