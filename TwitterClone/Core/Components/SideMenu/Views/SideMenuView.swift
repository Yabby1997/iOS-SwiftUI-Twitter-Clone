//
//  SideMenuView.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/23.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            VStack(alignment: .leading) {
                Circle()
                    .frame(width: 48, height: 48)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Seunghun Yang")
                        .font(.headline)
                    Text("@yabby1997")
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
                        ProfileView()
                    } label: {
                        SideMenuRowView(viewModel: viewModel)
                    }
                case .logout:
                    Button {
                        print("Log out")
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

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
