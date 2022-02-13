//
//  TweetService.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/02/07.
//

import Firebase
import Combine

struct TweetService {
    
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
    
    func uploadTweet(caption: String) -> AnyPublisher<Void, Error> {
        guard let uid = Auth.auth().currentUser?.uid else { return Fail(error: Errors.notAuthenticated).eraseToAnyPublisher() }
        
        let data: [String: Any] = [
            "uid": uid,
            "caption": caption,
            "likes": 0,
            "timestamp": Timestamp(date: Date())
        ]
        
        return Future<Void, Error> { promise in
            Firestore.firestore().collection("tweets")
                .document()
                .setData(data) { error in
                    if let error = error { return promise(.failure(error)) }
                    promise(.success(()))
                }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchTweets() -> AnyPublisher<[Tweet], Error> {
        return Future<[Tweet], Error> { promise in
            Firestore.firestore().collection("tweets")
                .order(by: "timestamp", descending: true)
                .getDocuments { snapshot, error in
                    if let error = error { return promise(.failure(error)) }
                    guard let documents = snapshot?.documents else { return promise(.failure(Errors.invalidDocument)) }
                    return promise(.success(documents.compactMap { try? $0.data(as: Tweet.self) }))
                }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchTweets(for uid: String) -> AnyPublisher<[Tweet], Error> {
        return Future<[Tweet], Error> { promise in
            Firestore.firestore().collection("tweets")
                .whereField("uid", isEqualTo: uid)
                .getDocuments { snapshot, error in
                    if let error = error { return promise(.failure(error)) }
                    guard let documents = snapshot?.documents else { return promise(.failure(Errors.invalidDocument)) }
                    return promise(.success(documents.compactMap { try? $0.data(as: Tweet.self) }.sorted { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
                }
        }
        .eraseToAnyPublisher()
    }
}
