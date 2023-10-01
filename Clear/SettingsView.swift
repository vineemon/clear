//
//  SettingsView.swift
//  Clear
//
//  Created by Nadella, Vineet on 9/17/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var firestoreManager: FirestoreManager
    @State var isPersonalInformationViewActive = false
    @State var isLoggedOut = false
    @State var isChangePassword = false
    @State var isRemoveCourse = false
    @State var isAccountDelete = false
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Button() {
                    self.isPersonalInformationViewActive = true
                } label: {
                    Label("", systemImage: "person.fill").labelStyle(CenteredLabelStyle()).background(content: {
                        LinearGradient(
                            colors: [Color(red: 1.00, green: 1.00, blue: 1.00), Color(red: 0.95, green: 0.95, blue: 0.95)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(width: 40, height: 40)
                    }
                    ).frame(width: 40, height: 40).cornerRadius(100)
                    Text("Personal Information")
                    Spacer()
                    Label("", systemImage: "chevron.right")
                }.buttonStyle(.plain).cornerRadius(50)
                Button() {
                    self.isChangePassword = true
                } label: {
                    Label("", systemImage: "key.fill").labelStyle(CenteredLabelStyle()).background(content: {
                        LinearGradient(
                            colors: [Color(red: 1.00, green: 1.00, blue: 1.00), Color(red: 0.95, green: 0.95, blue: 0.95)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(width: 40, height: 40)
                    }
                    ).frame(width: 40, height: 40).cornerRadius(100)
                    Text("Change Password")
                    Spacer()
                    Label("", systemImage: "chevron.right")
                    
                }.buttonStyle(.plain).frame(alignment: .center).cornerRadius(50)
                Button {
                    self.isLoggedOut = true
//                    firestoreManager.signOut()
                } label: {
                    Label("", systemImage: "rectangle.portrait.and.arrow.right.fill").labelStyle(CenteredLabelStyle()).background(content: {
                        LinearGradient(
                            colors: [Color(red: 1.00, green: 1.00, blue: 1.00), Color(red: 0.95, green: 0.95, blue: 0.95)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(width: 40, height: 40)
                    }
                    ).frame(width: 40, height: 40).cornerRadius(100)
                    Text("Logout")
                    Spacer()
                    Label("", systemImage: "chevron.right")
                }.buttonStyle(.plain).frame(alignment: .center).cornerRadius(50)
                Button() {
                    self.isAccountDelete = true
                } label: {
                    Label("", systemImage: "trash.fill").labelStyle(CenteredLabelStyle()).background(content: {
                        LinearGradient(
                            colors: [Color(red: 1.00, green: 1.00, blue: 1.00), Color(red: 0.95, green: 0.95, blue: 0.95)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(width: 40, height: 40)
                    }
                    ).frame(width: 40, height: 40).cornerRadius(100)
                    Text("Delete Acount")
                    Spacer()
                    Label("", systemImage: "chevron.right")
                }.buttonStyle(.plain).frame(alignment: .center).cornerRadius(50)
                Spacer()
            }.padding().navigationTitle(Text("Settings")).navigationBarTitleDisplayMode(.inline).frame(maxWidth: .infinity, alignment: .leading)
                .navigationDestination(isPresented: $isLoggedOut, destination: {
                    LoginView().environmentObject(firestoreManager).navigationBarBackButtonHidden(true).navigationBarTitleDisplayMode(.inline)
                })
        }
    }
    
    struct CenteredLabelStyle: LabelStyle {
        func makeBody(configuration: Configuration) -> some View {
                HStack {
                    configuration.icon
                }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SettingsView()
        }
    }
}
