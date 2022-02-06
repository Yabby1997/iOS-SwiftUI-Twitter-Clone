//
//  ExploreViewModel.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/02/05.
//

import Combine
import Foundation

class ExploreViewModel: ObservableObject {
    @Published var error: Error? = nil
    @Published var users: [TwitterUser] = []
    @Published var searchText = ""
    
    var filteredUsers: [TwitterUser] {
        if self.searchText.isEmpty {
            return self.users
        } else {
            let lowerCasedQuery = searchText.lowercased()
            return self.users.filter { $0.username.lowercased().contains(lowerCasedQuery) || $0.fullname.lowercased().contains(lowerCasedQuery) }
        }
    }
    
    private let service: UserService
    private var cancellables: Set<AnyCancellable> = []
    
    init(service: UserService) {
        self.service = service
        self.fetchUsers()
    }
    
    private func fetchUsers() {
        self.service.fetchUsers()
            .sink { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                self?.error = error
            } receiveValue: { [weak self] users in
                self?.users = users
            }
            .store(in: &self.cancellables)
    }
}
