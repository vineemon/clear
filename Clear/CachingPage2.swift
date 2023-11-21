//
//  CachingPage2.swift
//  Clear
//
//  Created by Nadella, Vineet on 10/8/23.
//

import SwiftUI

struct CachingPage2: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Application server cache").font(.custom("Avenir", size: 25)).bold()
            Text("")
            Text("Placing a cache directly on a request layer node enables the local storage of response data. Each time a request is made to the service, the node will quickly return locally cached data if it exists. If it is not in the cache, the requesting node will fetch the data from the disk. The cache on one request layer node could also be located both in memory (which is very fast) and on the node's local disk (faster than going to network storage).").font(.custom("Avenir", size: 20)).frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }.toolbar {
            ToolbarItemGroup(placement: .principal) {
                Text("Caching").font(.custom("Avenir", size: 30)).bold()
            }
        }
    }
}

struct CachingPage2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                TabView {
                    CachingPage2()
                }.tabViewStyle(.page)
            }.padding()
        }
    }
}
