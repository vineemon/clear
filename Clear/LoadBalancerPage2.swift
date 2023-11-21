//
//  LoadBalancerPage2.swift
//  Clear
//
//  Created by Nadella, Vineet on 9/30/23.
//

import SwiftUI

struct LoadBalancerPage2: View {
    var body: some View {
        VStack() {
            Text("More about load balancers.").font(.custom("Avenir", size: 20)).bold().frame(maxWidth: .infinity, alignment: .leading)
            Text("")
            Text("Typically a load balancer sits between a user client and the server accepting incoming network and application traffic and distributing the traffic across multiple backend servers using various algorithms. By balancing application requests across multiple servers, a load balancer reduces individual server load and prevents any one application server from becoming a single point of failure, thus improving overall application availability and responsiveness.").frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Image("LoadBalancerIcon").resizable().scaledToFit()
            Spacer()
        }.toolbar {
            ToolbarItemGroup(placement: .principal) {
                Text("Load Balancer").font(.custom("Avenir", size: 30)).bold()
            }
        }
    }
}

struct LoadBalancerPage2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                TabView {
                    LoadBalancerPage2()
                }.tabViewStyle(.page)
            }.padding()
        }
    }
}
