//
//  TweetRowView.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/20.
//

import SwiftUI

import FirebaseFirestoreSwift
import Kingfisher

struct TweetRowView: View {
    let tweet: Tweet
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                if let user = self.tweet.user {
                    HStack(alignment: .top, spacing: 12) {
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 56, height: 56)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(user.fullname)
                                    .font(.subheadline).bold()
                                Text("@\(user.username)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("2w")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Text(self.tweet.caption)
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }
                HStack {
                    Button {
                        print("Hello")
                    } label: {
                        Image(systemName: "bubble.left")
                            .font(.subheadline)
                    }
                    Spacer()
                    Button {
                        print("Hello")
                    } label: {
                        Image(systemName: "arrow.2.squarepath")
                            .font(.subheadline)
                    }
                    Spacer()
                    Button {
                        print("Hello")
                    } label: {
                        Image(systemName: "heart")
                            .font(.subheadline)
                    }
                    Spacer()
                    Button {
                        print("Hello")
                    } label: {
                        Image(systemName: "bookmark")
                            .font(.subheadline)
                    }
                }
                .padding()
                .foregroundColor(.gray)
            }
            .padding()
            Divider()
        }
    }
}

//struct TweetRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TweetRowView(tweet: Tweet(caption: "Hello", timestamp: Timestamp(Date()), uid: "", likes: 5))
//            .previewLayout(.sizeThatFits)
//    }
//}
