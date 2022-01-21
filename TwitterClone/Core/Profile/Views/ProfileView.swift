//
//  ProfileView.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/20.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(alignment: .leading) {
            headerView
            actionButtons
            userInfoDetails
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension ProfileView {
    var headerView: some View {
        ZStack(alignment: .bottomLeading) {
            Color(.systemBlue)
                .ignoresSafeArea()
            
            VStack {
                Button {
                    
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 20, height: 16)
                        .foregroundColor(.white)
                        .offset(x: 16, y: 12)
                }
                Circle()
                    .frame(width: 72, height: 72)
                    .offset(x: 16, y: 24)
            }
        }
        .frame(height: 96)
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
                Text("Edit Profile")
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
                Text("Seunghun Yang")
                    .font(.title2).bold()
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(Color(.systemBlue))
            }
            Text("@yabby1997")
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
            
            HStack {
                HStack(spacing: 4) {
                    Text("76")
                        .font(.subheadline).bold()
                    Text("Following")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                HStack(spacing: 4) {
                    Text("94")
                        .font(.subheadline).bold()
                    Text("Followers")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical)
        }
        .padding(.horizontal)
    }
}
