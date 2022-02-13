//
//  UploadTwitViewModel.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/02/07.
//

import Combine
import Foundation

class UploadTwitViewModel: ObservableObject {
    @Published var caption: String = ""
    @Published var error: Error? = nil
    @Published var didUploadTwit: Bool = false
    
    let service = TwitService()
    
    private var cancellables: Set<AnyCancellable> = []
    
    func uploadTwit() {
        self.service.uploadTwit(caption: self.caption)
            .sink { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                self?.error = error
            } receiveValue: { [weak self] _ in
                self?.didUploadTwit = true
            }
            .store(in: &self.cancellables)
    }
}
