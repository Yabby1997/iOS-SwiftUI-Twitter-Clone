//
//  ExploreView.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/20.
//

import SwiftUI

struct ExploreView: View {
    @ObservedObject private var viewModel: ExploreViewModel = ExploreViewModel(service: UserService())
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(self.viewModel.users) { user in
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            UserRowView(user: user)
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
