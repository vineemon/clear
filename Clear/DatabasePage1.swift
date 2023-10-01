//
//  DatabasePage1.swift
//  Clear
//
//  Created by Vineet Nadella on 9/12/23.
//

import SwiftUI

struct DatabasePage1: View {
    var body: some View {
        Group{
            VStack {
                Text("What is a database?").font(.title2).bold().frame(maxWidth: .infinity, alignment: .leading)
                Text("")
                Text("A database is information that is set up for easy access, management and updating. Computer databases typically store aggregations of data records or files that contain information, such as sales transactions, customer data, financials and product information.").frame(maxWidth: .infinity, alignment: .leading)
                Text("")
                Text("Databases are used for storing, maintaining and accessing any sort of data. They collect information on people, places or things. That information is gathered in one place so that it can be observed and analyzed. Databases can be thought of as an organized collection of information.").frame(maxWidth: .infinity, alignment: .leading)
                Image("DatabaseIcon").frame(maxWidth: .infinity)
                Spacer()
            }
        }
    }
}


struct DatabasePage1_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DatabasePage1()
        }.padding()
    }
}
