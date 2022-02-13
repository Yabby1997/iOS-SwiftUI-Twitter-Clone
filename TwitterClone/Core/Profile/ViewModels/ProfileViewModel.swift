//
//  ProfileViewModel.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/02/13.
//

import Combine
import Foundation

class ProfileViewModel: ObservableObject {
    let user: TwitterUser
    @Published var tweets: [Tweet] = []
    @Published var error: Error?
    
    private let service = TweetService()
    private var cancellables: Set<AnyCancellable> = []
    
    init(user: TwitterUser) {
        self.user = user
        self.fetchUserTweets()
    }
    
    func fetchUserTweets() {
        guard let uid = self.user.id else { return }
        self.service.fetchTweets(for: uid)
            .sink { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                self?.error = error
            } receiveValue: { [weak self] tweets in
                self?.tweets = tweets
                for (index, _) in tweets.enumerated() { self?.tweets[index].user = self?.user }
            }
            .store(in: &self.cancellables)
    }
}
