//
//  LoadBalancerPage1.swift
//  Clear
//
//  Created by Vineet Nadella on 9/12/23.
//

import SwiftUI

struct LoadBalancerPage1: View {
    var body: some View {
        VStack(alignment: .leading) {
//            Text("What is a database?").font(.system(size: 20)).bold()
            Text("")
            Text("Load Balancer (LB) is another critical component of any distributed system. It helps to spread the traffic across a cluster of servers to improve responsiveness and availability of applications, websites or databases. LB also keeps track of the status of all the resources while distributing requests. If a server is not available to take new requests or is not responding or has elevated error rate, LB will stop sending traffic to such a server.")
            Text("")
            Text("Typically a load balancer sits between the client and the server accepting incoming network and application traffic and distributing the traffic across multiple backend servers using various algorithms. By balancing application requests across multiple servers, a load balancer reduces individual server load and prevents any one application server from becoming a single point of failure, thus improving overall application availability and responsiveness.")
            Spacer()
        }
    }
}
