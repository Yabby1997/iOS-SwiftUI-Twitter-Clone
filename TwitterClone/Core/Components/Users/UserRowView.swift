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
            KFImage(URL(string: self.user.profileImageUrl))
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
        UserRowView(user: TwitterUser([
            "uid": "test@gmail.com",
            "username": "test",
            "fullname": "test user",
            "profileImage": "https://images.unsplash.com/photo-1494253109108-2e30c049369b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cmFuZG9tJTIwZm9vZCUyMHN0b3JlfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
            "email": "test@gmail.com"])!
        )
            .previewLayout(.sizeThatFits)
    }
}
