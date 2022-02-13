//
//  FeedViewModel.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/02/13.
//

import Combine
import Foundation

class FeedViewModel: ObservableObject {
    @Published var error: Error?
    @Published var twits: [Twit] = []
    
    private let twitService: TwitService = TwitService()
    private let userService: UserService = UserService()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        self.fetchTwits()
    }
    
    func fetchTwits() {
        self.twitService.fetchTwit()
            .sink { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                self?.error = error
            } receiveValue: { [weak self] twits in
                guard let self = self else { return }
                self.twits = twits
            
                for (index, twit) in twits.enumerated() {
                    self.userService.fetchUser(with: twit.uid)
                        .sink { [weak self] completion in
                            guard case .failure(let error) = completion else { return }
                            self?.error = error
                        } receiveValue: { [weak self] user in
                            self?.twits[index].user = user
                        }
                        .store(in: &self.cancellables)
                }
            }
            .store(in: &self.cancellables)
    }
}
