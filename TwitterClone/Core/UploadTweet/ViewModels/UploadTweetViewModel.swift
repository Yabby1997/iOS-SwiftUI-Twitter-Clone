//
//  UploadTweetViewModel.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/02/07.
//

import Combine
import Foundation

class UploadTweetViewModel: ObservableObject {
    @Published var caption: String = ""
    @Published var error: Error? = nil
    @Published var didUploadTweet: Bool = false
    
    let service = TweetService()
    
    private var cancellables: Set<AnyCancellable> = []
    
    func uploadTweet() {
        self.service.uploadTweet(caption: self.caption)
            .sink { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                self?.error = error
            } receiveValue: { [weak self] _ in
                self?.didUploadTweet = true
            }
            .store(in: &self.cancellables)
    }
}
