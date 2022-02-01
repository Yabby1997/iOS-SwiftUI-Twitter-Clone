//
//  DataUploader.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/02/01.
//

import Combine
import UIKit

import Firebase

enum DataUploader {
    
    enum Paths: String {
        case profileImages = "profileImages"
    }
    
    enum Errors: LocalizedError {
        case invalidUrl
        
        var errorDescription: String? {
            switch self {
            case .invalidUrl: return "올바르지 않은 URL입니다."
            }
        }
    }

    static func uploadData(path: Paths, data: Data) -> AnyPublisher<String, Error> {
        let fileName = UUID().uuidString
        let reference = Storage.storage().reference(withPath: "/\(path.rawValue)/\(fileName)")
        
        return Future<String, Error> { promise in
            reference.putData(data, metadata: nil) { _, error in
                if let error = error { print(error.localizedDescription) } //return promise(.failure(error)) }
                reference.downloadURL { url, error in
                    if let error = error { return promise(.failure(error)) }
                    guard let url = url?.absoluteString else { return promise(.failure(Errors.invalidUrl)) }
                    return promise(.success(url))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

