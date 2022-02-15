//
//  NewTweetView.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/24.
//

import SwiftUI

import Kingfisher

struct NewTweetView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var uploadTweetViewModel = UploadTweetViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color(.systemBlue))
                }
                
                Spacer()
                
                Button {
                    self.uploadTweetViewModel.uploadTweet()
                } label: {
                    Text("Tweet")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
            .padding()
            
            HStack(alignment: .top) {
                if let user = authViewModel.currentUser {
                    KFImage(URL(string: user.profileImage))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 64, height: 64)
                } else {
                    Circle()
                        .frame(width: 64, height: 64)
                }
                TextArea(text: self.$uploadTweetViewModel.caption, placeholder: "What's happening?")
            }
            .padding()
        }
        .onReceive(self.uploadTweetViewModel.$didUploadTweet) { isSucceed in
            if isSucceed { self.presentationMode.wrappedValue.dismiss() }
        }
    }
}

struct NewTweetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView()
    }
}
