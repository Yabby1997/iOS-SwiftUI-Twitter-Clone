//
//  ProfilePhotoSelectionView.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/31.
//

import SwiftUI

struct ProfilePhotoSelectionView: View {
    @State private var isImagePickerShowing: Bool = false
    @State private var selectedImage: UIImage?
    @EnvironmentObject private var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            AuthenticationHeaderView(title: "Create your account\nSelect a profile photo")
            Button {
                self.isImagePickerShowing.toggle()
            } label: {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 180, height: 180)
                        .padding(.top, 44)
                } else {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 4)
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFill()
                            .padding(70)
                    }
                    .frame(width: 180, height: 180)
                    .padding(.top, 44)
                }
            }
            
            if let image = selectedImage {
                Button {
                    viewModel.uploadProfileImage(image)
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            }

            Spacer()
        }
        .ignoresSafeArea()
        .sheet(isPresented: self.$isImagePickerShowing) {
            ImagePicker(selectedImage: self.$selectedImage)
        }
    }
}

struct ProfilePhotoSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectionView()
    }
}
