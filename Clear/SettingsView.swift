//
//  SettingsView.swift
//  Clear
//
//  Created by Nadella, Vineet on 9/17/23.
//

import SwiftUI

struct SettingsView: View {
    @State var isPersonalInformationViewActive = false
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Button() {
                    self.isPersonalInformationViewActive = true
                } label: {
                    Label("", systemImage: "person.fill").background(alignment: .center, content: {
                        LinearGradient(
                            colors: [.green, .blue],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(width: 40, height: 40, alignment: .center)
                    }
                    ).frame(width: 40, height: 40, alignment: .center).cornerRadius(100)
                    Text("Personal Information")
                
                }.buttonStyle(.plain).frame(alignment: .center).cornerRadius(50)
                Button() {
                    self.isPersonalInformationViewActive = true
                } label: {
                    Label("", systemImage: "key.fill").padding()
                    Text("Change Password")
                
                }.buttonStyle(.plain).frame(alignment: .center).cornerRadius(50)
                Button() {
                    self.isPersonalInformationViewActive = true
                } label: {
                    Label("", systemImage: "pencil.slash").padding()
                    Text("Remove Course")
                
                }.buttonStyle(.plain).frame(alignment: .center).cornerRadius(50)
                Button() {
                    self.isPersonalInformationViewActive = true
                } label: {
                    Label("", systemImage: "rectangle.portrait.and.arrow.right.fill").padding()
                    Text("Logout")
                }.buttonStyle(.plain).frame(alignment: .center).cornerRadius(50)
                Button() {
                    self.isPersonalInformationViewActive = true
                } label: {
                    Label("", systemImage: "trash.circle.fill").padding()
                    Text("Delete Acount")
                }.buttonStyle(.plain).frame(alignment: .center).cornerRadius(50)
                Spacer()
            }.padding().navigationTitle(Text("Profile Settings")).navigationBarTitleDisplayMode(.inline).frame(maxWidth: .infinity, alignment: .leading) // << make screen-wide !!
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
