//
//  SideMenuRowView.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/23.
//

import SwiftUI

struct SideMenuRowView: View {
    let viewModel: SideMenuViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: self.viewModel.imageName)
                .font(.headline)
                .foregroundColor(.gray)
            
            Text(self.viewModel.title)
                .font(.subheadline)
                .foregroundColor(.black)
            
            Spacer()
        }
        .frame(height: 40)
        .padding(.horizontal)
    }
}

struct SideMenuRowView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuRowView(viewModel: .profile)
            .previewLayout(.sizeThatFits)
    }
}
