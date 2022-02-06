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
            SearchBar(text: self.$viewModel.searchText)
                .padding(.horizontal, 4)
            ScrollView {
                LazyVStack {
                    ForEach(self.viewModel.filteredUsers) { user in
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
