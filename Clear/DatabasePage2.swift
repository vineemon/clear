//
//  DatabasePage2.swift
//  Clear
//
//  Created by Nadella, Vineet on 10/6/23.
//

import SwiftUI

struct DatabasePage2: View {
    var body: some View {
        VStack {
            Text("Database Management System (DBMS)").font(.custom("Avenir", size: 25)).bold().frame(maxWidth: .infinity, alignment: .leading)
            Text("")
            Text("Database Management Systems (DBMS) are software systems used to store, retrieve, and run queries on data. A DBMS serves as an interface between an end-user and a database, allowing users to create, read, update, and delete data in the database.").font(.custom("Avenir", size: 20)).frame(maxWidth: .infinity, alignment: .leading)
            Text("")
            Text("DBMS manage the data, the database engine, and the database schema, allowing for data to be manipulated or extracted by users and other programs. This helps provide data security, data integrity, concurrency, and uniform data administration procedures.").font(.custom("Avenir", size: 20)).frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Image("DBMSIcon").resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
        }.toolbar {
            ToolbarItemGroup(placement: .principal) {
                Text("Databases").font(.custom("Avenir", size: 30)).bold()
            }
        }
    }
}


struct DatabasePage2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                TabView {
                    DatabasePage2()
                }.tabViewStyle(.page)
            }.padding()
        }
    }
}
