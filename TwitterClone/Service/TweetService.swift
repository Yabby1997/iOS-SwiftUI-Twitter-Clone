//
//  TweetService.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/02/07.
//

import Firebase
import Combine

class TweetService {
    
    enum Errors: LocalizedError {
        case notAuthenticated
        case invalidSnapshot
        case invalidTweetId
        
        var errorDescription: String? {
            switch self {
            case .notAuthenticated: return "유저가 로그인되어있지 않습니다."
            case .invalidSnapshot: return "스냅샷이 유효하지 않습니다."
            case .invalidTweetId: return "트윗 ID가 유효하지 않습니다."
            }
        }
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
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
                    guard let documents = snapshot?.documents else { return promise(.failure(Errors.invalidSnapshot)) }
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
                    guard let documents = snapshot?.documents else { return promise(.failure(Errors.invalidSnapshot)) }
                    return promise(.success(documents.compactMap { try? $0.data(as: Tweet.self) }.sorted { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
                }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchTweet(for document: QueryDocumentSnapshot) -> AnyPublisher<Tweet, Error> {
        return Future<Tweet, Error> { promise in
            Firestore.firestore().collection("tweets").document(document.documentID).getDocument { snapshot, error in
                if let error = error { return promise(.failure(error)) }
                guard let tweet = try? snapshot?.data(as: Tweet.self) else { return }
                return promise(.success(tweet))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchLikedTweets(for uid: String) -> AnyPublisher<[Tweet], Error> {
        return Future<[Tweet], Error> { promise in
            Firestore.firestore().collection("users").document(uid).collection("user-likes").getDocuments { [weak self] snapshot, error in
                guard let self = self else { return }
                if let error = error { return promise(.failure(error)) }
                guard let documents = snapshot?.documents else { return promise(.failure(Errors.invalidSnapshot)) }
                let tweetPublishers = documents.map { self.fetchTweet(for: $0) }
                
                Publishers.MergeMany(tweetPublishers)
                    .collect()
                    .sink { completion in
                        guard case .failure(let error) = completion else { return }
                        return promise(.failure(error))
                    } receiveValue: { tweets in
                        return promise(.success(tweets.sorted { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
                    }
                    .store(in: &self.cancellables)
            }
        }
        .eraseToAnyPublisher()
    }
    
    func likeTweet(tweet: Tweet) -> AnyPublisher<Void, Error> {
        guard let uid = Auth.auth().currentUser?.uid else { return Fail(error: Errors.notAuthenticated).eraseToAnyPublisher() }
        guard let tweetId = tweet.id else { return Fail(error: Errors.invalidTweetId).eraseToAnyPublisher() }
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        return Future<Void, Error> { promise in
            userLikesRef.document(tweetId).getDocument { snapshot, error in
                if let error = error { return promise(.failure(error)) }
                guard let snapshot = snapshot else { return promise(.failure(Errors.invalidSnapshot)) }
                
                if snapshot.exists {
                    userLikesRef.document(tweetId).delete { error in
                        if let error = error { return promise(.failure(error)) }
                        Firestore.firestore().collection("tweets").document(tweetId).updateData(["likes": tweet.likes - 1]) { error in
                            if let error = error { return promise(.failure(error)) }
                            return promise(.success(()))
                        }
                    }
                } else {
                    userLikesRef.document(tweetId).setData([:]) { error in
                        if let error = error { return promise(.failure(error)) }
                        Firestore.firestore().collection("tweets").document(tweetId).updateData(["likes": tweet.likes + 1]) { error in
                            if let error = error { return promise(.failure(error)) }
                            return promise(.success(()))
                        }
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func checkIfUserLikedTweet(tweet: Tweet) -> AnyPublisher<Bool, Error> {
        guard let uid = Auth.auth().currentUser?.uid else { return Fail(error: Errors.notAuthenticated).eraseToAnyPublisher() }
        guard let tweetId = tweet.id else { return Fail(error: Errors.invalidTweetId).eraseToAnyPublisher() }
        
        return Future<Bool, Error> { promise in
            Firestore.firestore().collection("users").document(uid).collection("user-likes")
                .document(tweetId).getDocument { snapshot, error in
                    if let error = error { return promise(.failure(error)) }
                    guard let snapshot = snapshot else { return promise(.failure(Errors.invalidSnapshot)) }
                    return promise(.success(snapshot.exists))
                }
        }
        .eraseToAnyPublisher()
    }
}
