//
//  AddCoursesView.swift
//  Clear
//
//  Created by Nadella, Vineet on 9/29/23.
//

import SwiftUI

struct AddCoursesView: View {
    @EnvironmentObject var firestoreManager: FirestoreManager
    @State var isSettingsActive = false
    @State var isHomeOpen = false
    @State var isLoggedOut = false
    @State var isProfileOpen = false
    @State private var selectedCourse: CloudCourse = .dataPartitioning
    
    var body: some View {
        HStack {
            Text("Add Course: ")
            Picker("Add Course: ", selection: $selectedCourse) {
                ForEach(CloudCourse.allCases) { course in
                    Text(course.cloudProject.title)
                        .tag(course.cloudProject)
                }
            }
        }
        Button(action: submitEvent) {
            Text("Submit").padding().frame(width: 200)
        }.frame(alignment: .center).background(alignment: .center, content: {
            RadialGradient(
                colors: [.blue, .white],
                center: .center,
                startRadius: 0,
                endRadius: 300)
            .frame(width: 200, height: 40, alignment: .center)
        }
        ).frame(width: 200, height: 40, alignment: .center).cornerRadius(50).foregroundColor(.white).toolbar {
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
                } label: {
                    Image(systemName: "plus.app").foregroundColor(.black)
                }
                Spacer()
                Button {
                    self.isProfileOpen = true
                } label: {
                    VStack{
                        Image(systemName:"person.fill").foregroundColor(.black)
                        Text("Profile").font(.footnote).foregroundColor(.black)
                    }
                }
                Spacer()
            }
            
            ToolbarItemGroup(placement: .principal) {
                Text("Add Courses").font(.title).bold()
            }
        }.navigationDestination(isPresented: $isHomeOpen, destination: {
            ContentView().environmentObject(firestoreManager).navigationBarBackButtonHidden(true)
        }).navigationDestination(isPresented: $isProfileOpen, destination: {
            ProfileView().environmentObject(firestoreManager).navigationBarBackButtonHidden(true)
        })
    }
    
    
    func submitEvent() {
        let index = firestoreManager.cloudProjects.insertionIndexOf(selectedCourse.cloudProject) { $0.title < $1.title }
        // cannot add existing course
        if (index != -1) {
            firestoreManager.cloudProjects.insert(selectedCourse.cloudProject, at: index)
            firestoreManager.save()
        }
    }
}


extension Array {
    func insertionIndexOf(_ elem: Element, isOrderedBefore: (Element, Element) -> Bool) -> Int {
        var lo = 0
        var hi = self.count - 1
        while lo <= hi {
            let mid = (lo + hi)/2
            if isOrderedBefore(self[mid], elem) {
                lo = mid + 1
            } else if isOrderedBefore(elem, self[mid]) {
                hi = mid - 1
            } else {
                return -1 // found at position mid
            }
        }
        return lo // not found, would be inserted at position lo
    }
}


#Preview {
    AddCoursesView()
}
