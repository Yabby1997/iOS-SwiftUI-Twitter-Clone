//
//  ExploreView.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/20.
//

import SwiftUI

struct ExploreView: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(0...20, id: \.self) { _ in
                        NavigationLink {
                            if let currentUser = self.viewModel.currentUser {
                                ProfileView(user: currentUser)
                            }
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
