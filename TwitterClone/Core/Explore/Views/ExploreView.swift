//
//  ExploreView.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/20.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(0...20, id: \.self) { _ in
                        NavigationLink {
                            ProfileView()
                        } label: {
                            UserRowView()
                        }
                    }
                }
            }
        }
        .navigationTitle("Explore")
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
