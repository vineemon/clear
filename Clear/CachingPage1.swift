//
//  CachingPage1.swift
//  Clear
//
//  Created by Vineet Nadella on 9/12/23.
//

import SwiftUI

struct CachingPage1: View {
    @EnvironmentObject var firestoreManager: FirestoreManager
    var body: some View {
        VStack(alignment: .leading) {
            Text("What is a cache?").font(.custom("Avenir", size: 25)).bold()
            Text("")
            Text("A cache is a high-speed data storage layer which stores a subset of data so that future requests for that data are served up faster than would be possible by accessing the data storage primary location. Caches enable you to make vastly better use of the resources you already have as well as making otherwise unattainable product requirements feasible. Caches can exist at all levels in architecture, but are often found at the level nearest to the front end, where they are implemented to return data quickly without taxing downstream levels.").font(.custom("Avenir", size: 20)).frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }.toolbar {
            ToolbarItemGroup(placement: .principal) {
                Text("Caching").font(.custom("Avenir", size: 30)).bold()
            }
        }
    }
}

struct CachingPage1_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                TabView {
                    CachingPage1()
                }.tabViewStyle(.page)
            }.padding()
        }
    }
}
