//
//  TwitService.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/02/07.
//

import Firebase
import Combine

struct TwitService {
    
    enum Errors: LocalizedError {
        case notAuthenticated
        case invalidDocument
        
        var errorDescription: String? {
            switch self {
            case .notAuthenticated: return "유저가 로그인되어있지 않습니다."
            case .invalidDocument: return "도큐먼트가 유효하지 않습니다."
            }
        }
    }
    
    func uploadTwit(caption: String) -> AnyPublisher<Void, Error> {
        guard let uid = Auth.auth().currentUser?.uid else { return Fail(error: Errors.notAuthenticated).eraseToAnyPublisher() }
        
        let data: [String: Any] = [
            "uid": uid,
            "caption": caption,
            "likes": 0,
            "timestamp": Timestamp(date: Date())
        ]
        
        return Future<Void, Error> { promise in
            Firestore.firestore().collection("twits")
                .document()
                .setData(data) { error in
                    if let error = error { return promise(.failure(error)) }
                    promise(.success(()))
                }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchTwit() -> AnyPublisher<[Twit], Error> {
        return Future<[Twit], Error> { promise in
            Firestore.firestore().collection("twits")
                .getDocuments { snapshot, error in
                    if let error = error { return promise(.failure(error)) }
                    guard let documents = snapshot?.documents else { return promise(.failure(Errors.invalidDocument)) }
                    return promise(.success(documents.compactMap { try? $0.data(as: Twit.self) }))
                }
        }
        .eraseToAnyPublisher()
    }
}