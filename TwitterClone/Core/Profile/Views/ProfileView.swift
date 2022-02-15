//
//  ProfileView.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/20.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @State private var selectedCategory: TweetFilterViewModel = .tweets
    @ObservedObject private var viewModel: ProfileViewModel
    @Environment(\.presentationMode) var mode
    @Namespace private var animation
    
    init(user: TwitterUser) {
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            headerView
            actionButtons
            userInfoDetails
            tweetFilterBar
            tweetsView
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: TwitterUser(id: "test", username: "test", fullname: "test", profileImage: "", email: "test"))
    }
}

extension ProfileView {
    var headerView: some View {
        ZStack(alignment: .bottomLeading) {
            Color(.systemBlue)
                .ignoresSafeArea()
            
            VStack {
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 20, height: 16)
                        .foregroundColor(.white)
                        .offset(x: 16, y: -16)
                }
                KFImage(URL(string: self.viewModel.user.profileImage))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 72, height: 72)
                    .offset(x: 16, y: 24)
            }
        }
        .frame(height: 140)
    }
    
    var actionButtons: some View {
        HStack {
            Spacer()
            
            Image(systemName: "bell.badge")
                .font(.title3)
                .padding(6)
                .overlay(Circle().stroke(Color.gray, lineWidth: 0.75))
            
            Button {
                print("!")
            } label: {
                Text(self.viewModel.user.isCurrentUser ? "Edit Profile" : "Follow")
                    .font(.subheadline).bold()
                    .frame(width: 120, height: 32)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.75))
                    .foregroundColor(.black)
            }

        }
        .padding(.trailing)
    }
    
    var userInfoDetails: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(self.viewModel.user.fullname)
                    .font(.title2).bold()
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(Color(.systemBlue))
            }
            Text("@\(self.viewModel.user.username)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("SwiftUI는 정말 재밌어")
                .font(.subheadline)
                .padding(.vertical)
            
            HStack(spacing: 24) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Daejeon, KR")
                }
                .font(.caption)
                .foregroundColor(.gray)
                
                HStack {
                    Image(systemName: "link")
                    Text("https://seunghun-ios.notion.site")
                }
                .font(.caption)
                .foregroundColor(.gray)
            }
            
            UserStatsView()
            .padding(.vertical)
        }
        .padding(.horizontal)
    }
    
    var tweetFilterBar: some View {
        HStack {
            ForEach(TweetFilterViewModel.allCases, id: \.rawValue) { category in
                VStack {
                    Text(category.title)
                        .font(.subheadline)
                        .fontWeight(selectedCategory == category ? .semibold : .regular)
                        .foregroundColor(selectedCategory == category ? .black : .gray)
                    
                    if selectedCategory == category {
                        Capsule()
                            .foregroundColor(Color(.systemBlue))
                            .matchedGeometryEffect(id: "filter", in: animation)
                            .frame(height: 3)
                    } else {
                        Capsule()
                            .foregroundColor(.clear)
                            .frame(height: 3)
                    }
                    
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedCategory = category
                    }
                }
            }
        }
        .overlay(Divider().offset(x: 0, y: 16))
    }
    
    var tweetsView: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(self.viewModel.tweets(for: self.selectedCategory)) { tweet in
                        TweetRowView(tweet: tweet)
                    }
                }
            }
        }
    }
}
