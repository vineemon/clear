//
//  PlainView.swift
//  Clear
//
//  Created by Nadella, Vineet on 10/7/23.
//

import SwiftUI

struct PlainView: View {
    var body: some View {
        Group{
            VStack {
                Text("Yet to be developed").font(.title2).bold().frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
        }
    }
}


struct PlainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PlainView()
        }.padding()
    }
}
