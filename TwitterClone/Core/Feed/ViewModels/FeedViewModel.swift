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
    @Published var tweets: [Tweet] = []
    
    private let tweetService: TweetService = TweetService()
    private let userService: UserService = UserService()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        self.fetchTweets()
    }
    
    func fetchTweets() {
        self.tweetService.fetchTweets()
            .sink { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                self?.error = error
            } receiveValue: { [weak self] tweets in
                guard let self = self else { return }
                self.tweets = tweets
            
                for (index, tweet) in tweets.enumerated() {
                    self.userService.fetchUser(with: tweet.uid)
                        .sink { [weak self] completion in
                            guard case .failure(let error) = completion else { return }
                            self?.error = error
                        } receiveValue: { [weak self] user in
                            self?.tweets[index].user = user
                        }
                        .store(in: &self.cancellables)
                }
            }
            .store(in: &self.cancellables)
    }
}
