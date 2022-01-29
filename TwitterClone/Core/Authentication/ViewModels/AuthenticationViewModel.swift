//
//  AuthenticationViewModel.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/28.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var error: Error?
    @Published var userSession: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            self?.error = error
            guard let user = result?.user else { return }
            self?.userSession = user
        }
    }
    
    func register(email: String, username: String, fullname: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            self?.error = error
            guard let user = result?.user else { return }
            self?.userSession = user
            
            let data = [
                "uid": user.uid,
                "email": email,
                "username": username.lowercased(),
                "fullname": fullname
            ]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch(let error) {
            self.error = error
        }
    }
}
