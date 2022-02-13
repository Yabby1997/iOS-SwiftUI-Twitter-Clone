//
//  Twit.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/02/13.
//

import Firebase
import FirebaseFirestoreSwift

struct Twit: Identifiable, Decodable {
    @DocumentID var id: String?
    var user: TwitterUser?
    let caption: String
    let timestamp: Timestamp
    let uid: String
    var likes: Int
}
