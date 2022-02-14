//
//  TweetRowViewModel.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/02/14.
//

import Combine
import Foundation

class TweetRowViewModel: ObservableObject {
    @Published var error: Error?
    @Published var tweet: Tweet
    private let tweetService: TweetService = TweetService()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.checkIfUserLikedTweet()
    }
    
    func likeTweet() {
        self.tweetService.likeTweet(tweet: self.tweet)
            .sink { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                self?.error = error
            } receiveValue: { [weak self] _ in
                self?.checkIfUserLikedTweet()
            }
            .store(in: &self.cancellables)
    }
    
    func checkIfUserLikedTweet() {
        self.tweetService.checkIfUserLikedTweet(tweet: self.tweet)
            .sink { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                self?.error = error
            } receiveValue: { [weak self] didLiked in
                self?.tweet.didLiked = didLiked
            }
            .store(in: &self.cancellables)
    }
}
