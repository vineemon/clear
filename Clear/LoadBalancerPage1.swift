//
//  LoadBalancerPage1.swift
//  Clear
//
//  Created by Vineet Nadella on 9/12/23.
//

import SwiftUI

struct LoadBalancerPage1: View {
    var body: some View {
        VStack() {
            Text("What is a load balancer?").font(.title2).bold().frame(maxWidth: .infinity, alignment: .leading)
            Text("")
            Text("A load balancer (LB) is a critical component of any distributed system. It helps spread incoming customer traffic across a cluster of servers to improve responsiveness and availability of applications, websites or databases. LB also keeps track of the status of all the resources while distributing requests. If a server is not available to take new requests or is not responding or has elevated error rate, LB will stop sending traffic to such a server.").frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
    }
}

struct LoadBalancerPage1_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoadBalancerPage1()
        }.padding()
    }
}
