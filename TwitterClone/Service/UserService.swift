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
        case invalidSnapshot
        case decodingFailed
        
        var errorDescription: String? {
            switch self {
            case .invalidSnapshot: return "도큐먼트 스냅샷이 올바르지 않습니다."
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
                    guard let twitterUser = try? snapshot?.data(as: TwitterUser.self) else { return promise(.failure(Errors.invalidSnapshot)) }
                    return promise(.success(twitterUser))
                }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchUsers() -> AnyPublisher<[TwitterUser], Error> {
        return Future { promise in
            Firestore.firestore().collection("users")
                .getDocuments { snapshot, error in
                    if let error = error { return promise(.failure(error)) }
                    guard let documents = snapshot?.documents else { return promise(.failure(Errors.decodingFailed)) }
                    return promise(.success(documents.compactMap { try? $0.data(as: TwitterUser.self) } ))
                }
        }
        .eraseToAnyPublisher()
    }
}
