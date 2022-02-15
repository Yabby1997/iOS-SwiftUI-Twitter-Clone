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
    @Published var likedTweets: [Tweet] = []
    @Published var error: Error?
    
    private let userService = UserService()
    private let tweetService = TweetService()
    private var cancellables: Set<AnyCancellable> = []
    
    init(user: TwitterUser) {
        self.user = user
        self.fetchUserTweets()
        self.fetchLikedTweets()
    }
    
    func tweets(for filter: TweetFilterViewModel) -> [Tweet] {
        switch filter {
        case .tweets: return self.tweets
        case .replies: return self.tweets
        case .likes: return self.likedTweets
        }
    }
    
    func fetchUserTweets() {
        guard let uid = self.user.id else { return }
        self.tweetService.fetchTweets(for: uid)
            .sink { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                self?.error = error
            } receiveValue: { [weak self] tweets in
                self?.tweets = tweets
                for (index, _) in tweets.enumerated() { self?.tweets[index].user = self?.user }
            }
            .store(in: &self.cancellables)
    }
    
    func fetchLikedTweets() {
        guard let uid = self.user.id else { return }
        self.tweetService.fetchLikedTweets(for: uid)
            .sink { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                self?.error = error
            } receiveValue: { [weak self] tweets in
                guard let self = self else { return }
                self.likedTweets = tweets
                for (index, tweet) in tweets.enumerated() {
                    self.userService.fetchUser(with: tweet.uid)
                        .sink { [weak self] completion in
                            guard case .failure(let error) = completion else { return }
                            self?.error = error
                        } receiveValue: { [weak self] user in
                            self?.likedTweets[index].user = user
                        }
                        .store(in: &self.cancellables)
                }
            }
            .store(in: &self.cancellables)

    }
}
