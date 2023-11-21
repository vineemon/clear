//
//  DatabasePage1.swift
//  Clear
//
//  Created by Vineet Nadella on 9/12/23.
//

import SwiftUI

struct DatabasePage1: View {
    var body: some View {
        VStack {
            Text("What is a database?").font(.custom("Avenir", size: 25)).bold().frame(maxWidth: .infinity, alignment: .leading)
            Text("")
            Text("A database is an organized collection of structured information, or data, typically stored electronically in a computer system. A database is usually controlled by a database management system (DBMS). Databases are used for storing, maintaining and accessing any sort of data. They collect information on people, places or things. That information is gathered in one place so that it can be observed and analyzed.").font(.custom("Avenir", size: 20)).frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Image("DatabaseIcon").frame(maxWidth: .infinity)
            Spacer()
        }.toolbar {
            ToolbarItemGroup(placement: .principal) {
                Text("Databases").font(.custom("Avenir", size: 30)).bold()
            }
        }
    }
}


struct DatabasePage1_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                TabView {
                    DatabasePage1()
                }.tabViewStyle(.page)
            }.padding()
        }
    }
}
