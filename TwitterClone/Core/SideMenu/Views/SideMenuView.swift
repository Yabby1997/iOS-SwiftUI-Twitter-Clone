//
//  SideMenuView.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/23.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let currentUser = self.viewModel.currentUser {
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading) {
                    KFImage(URL(string: currentUser.profileImage))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 48, height: 48)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(currentUser.fullname)
                            .font(.headline)
                        Text("@\(currentUser.username)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    UserStatsView()
                        .padding(.vertical)
                }
                .padding(.leading)
                
                ForEach(SideMenuViewModel.allCases, id: \.rawValue) { viewModel in
                    switch viewModel {
                    case .profile:
                        NavigationLink {
                            ProfileView(user: currentUser)
                        } label: {
                            SideMenuRowView(viewModel: viewModel)
                        }
                    case .logout:
                        Button {
                            self.viewModel.signOut()
                        } label: {
                            SideMenuRowView(viewModel: viewModel)
                        }
                        
                    default: SideMenuRowView(viewModel: viewModel)
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
