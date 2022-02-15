//
//  UserRowView.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/22.
//

import SwiftUI
import Kingfisher

struct UserRowView: View {
    private let user: TwitterUser
    
    init(user: TwitterUser) {
        self.user = user
    }
    
    var body: some View {
        HStack(spacing: 12) {
            KFImage(URL(string: self.user.profileImage))
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 48, height: 48)
            VStack(alignment: .leading, spacing: 4) {
                Text(self.user.username)
                    .font(.subheadline).bold()
                    .foregroundColor(.black)
                Text(self.user.fullname)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: TwitterUser(id: "test", username: "test", fullname: "test", profileImage: "", email: "test"))
            .previewLayout(.sizeThatFits)
    }
}
