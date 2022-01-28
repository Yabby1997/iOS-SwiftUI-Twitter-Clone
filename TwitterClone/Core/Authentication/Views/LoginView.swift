//
//  LoginView.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            AuthenticationHeaderView(title: "Hello.\nWelcome Back")
            
            VStack(spacing: 40) {
                CustomTextField(imageName: "envelope", placeholderText: "Email", text: $email)
                CustomTextField(imageName: "lock", placeholderText: "Password", text: $password)
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            HStack {
                Spacer()
                NavigationLink {
                    Text("Reset password view..")
                } label: {
                    Text("Forgot Password?")
                        .font(.caption)
                        .foregroundColor(Color(.systemBlue))
                }
                .padding(.top)
                .padding(.trailing, 24)
            }
            
            Button {
                self.viewModel.login(email: self.email, password: self.password)
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)

            Spacer()
            
            NavigationLink {
                RegistrationView()
                    .navigationBarHidden(true)
            } label: {
                Text("Don't you have an account?")
                    .font(.footnote)
                Text("Sign Up")
                    .font(.footnote)
                    .fontWeight(.semibold)
            }
            .foregroundColor(Color(.systemBlue))
            .padding(.bottom, 32)
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
