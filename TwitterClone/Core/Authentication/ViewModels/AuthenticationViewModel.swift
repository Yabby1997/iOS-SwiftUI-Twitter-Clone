//
//  AuthenticationViewModel.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/28.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func login(email: String, password: String) {
        print(#function)
    }
    
    func register(email: String, username: String, fullname: String, password: String) {
        print(#function)
    }
}
