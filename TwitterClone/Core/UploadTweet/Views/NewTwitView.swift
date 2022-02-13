//
//  NewTwitView.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/24.
//

import SwiftUI

import Kingfisher

struct NewTwitView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var uploadTwitViewModel = UploadTwitViewModel()
    
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
                    self.uploadTwitViewModel.uploadTwit()
                } label: {
                    Text("Twit")
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
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 64, height: 64)
                } else {
                    Circle()
                        .frame(width: 64, height: 64)
                }
                TextArea(text: self.$uploadTwitViewModel.caption, placeholder: "What's happening?")
            }
            .padding()
        }
        .onReceive(self.uploadTwitViewModel.$didUploadTwit) { isSucceed in
            if isSucceed { self.presentationMode.wrappedValue.dismiss() }
        }
    }
}

struct NewTwitView_Previews: PreviewProvider {
    static var previews: some View {
        NewTwitView()
    }
}
