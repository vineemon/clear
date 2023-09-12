//
//  CardView.swift
//  Clear
//
//  Created by Vineet Nadella on 9/8/23.
//

import SwiftUI

struct CardView: View {
    let cloudProject: CloudProject
    var body: some View {
    VStack(alignment: .leading) {
        Text(cloudProject.title)
            .font(.headline)
            .accessibilityAddTraits(.isHeader)
        HStack {
            Label("5", systemImage: "person.3")
            Spacer()
            Label("\(cloudProject.time)", systemImage: "clock")
                .padding(.trailing, 20)
        }
        .font(.caption)
    }
    .padding()
    .foregroundColor(cloudProject.theme.accentColor)
}
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(nil)
//    }
//}
