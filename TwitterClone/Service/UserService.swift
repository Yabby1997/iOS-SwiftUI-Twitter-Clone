//
//  UserService.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/02/02.
//

import Combine

import Firebase
import FirebaseFirestoreSwift

class UserService {
    
    enum Errors: LocalizedError {
        case decodingFailed
        
        var errorDescription: String? {
            switch self {
            case .decodingFailed: return "유저 도큐먼트 디코딩에 실패했습니다."
            }
        }
    }
    
    func fetchUser(with uid: String) -> AnyPublisher<TwitterUser, Error> {
        return Future { promise in
            Firestore.firestore().collection("users")
                .document(uid)
                .getDocument { snapshot, error in
                    if let error = error { return promise(.failure(error)) }
                    guard let snapshot = snapshot,
                          let twitterUserDocument = snapshot.data(),
                          let twitterUser = TwitterUser(twitterUserDocument) else {
                              return promise(.failure(Errors.decodingFailed))
                          }
                    return promise(.success(twitterUser))
                }
        }
        .eraseToAnyPublisher()
    }
}
