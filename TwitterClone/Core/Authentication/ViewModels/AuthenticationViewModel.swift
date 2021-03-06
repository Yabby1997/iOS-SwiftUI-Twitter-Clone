//
//  AuthenticationViewModel.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/28.
//

import SwiftUI
import Combine

import Firebase

class AuthViewModel: ObservableObject {
    @Published var error: Error?
    @Published var userSession: User?
    @Published var tempSession: User?
    @Published var userDidAuthenticatedSignal: Bool = false
    @Published var currentUser: TwitterUser? = nil
    private let userService: UserService = UserService()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            self?.error = error
            guard let user = result?.user else { return }
            self?.userSession = user
            self?.fetchUser()
        }
    }
    
    func register(email: String, username: String, fullname: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            self?.error = error
            guard let user = result?.user else { return }
            self?.tempSession = user
            
            let data = [
                "uid": user.uid,
                "email": email,
                "username": username.lowercased(),
                "fullname": fullname
            ]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { [weak self] error in
                    if let error = error { self?.error = error }
                    self?.userDidAuthenticatedSignal = true
                }
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
    
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = self.tempSession?.uid,
              let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        DataUploader.uploadData(path: .profileImages, data: imageData)
            .sink { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                self?.error = error
            } receiveValue: { [weak self] url in
                Firestore.firestore().collection("users")
                    .document(uid)
                    .updateData(["profileImage": url]) { error in
                        if let error = error { self?.error = error }
                        self?.userSession = self?.tempSession
                        self?.fetchUser()
                    }
            }
            .store(in: &self.cancellables)
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        self.userService.fetchUser(with: uid)
            .sink { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                self?.error = error
            } receiveValue: { [weak self] user in
                self?.currentUser = user
            }
            .store(in: &self.cancellables)
    }
}
