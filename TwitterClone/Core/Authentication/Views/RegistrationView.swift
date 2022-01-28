//
//  RegistrationView.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/25.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            AuthenticationHeaderView(title: "Get started.\nCreate your account")
            
            VStack(spacing: 40) {
                CustomTextField(imageName: "envelope", placeholderText: "E-mail", text: self.$email)
                CustomTextField(imageName: "person", placeholderText: "Username", text: self.$username)
                CustomTextField(imageName: "person", placeholderText: "Full name", text: self.$fullname)
                CustomTextField(imageName: "lock", placeholderText: "Password", text: self.$password)
            }
            .padding(32)
            
            Button {
                self.viewModel.register(
                    email: self.email,
                    username: self.username,
                    fullname: self.fullname,
                    password: self.password
                )
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            Spacer()
            
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Already have an account?")
                    .font(.footnote)
                Text("Sign In")
                    .font(.footnote)
                    .fontWeight(.semibold)
            }
            .padding(.bottom, 32)
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
