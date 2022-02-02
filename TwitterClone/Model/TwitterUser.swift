//
//  TwitterUser.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/02/02.
//

import FirebaseFirestoreSwift

struct TwitterUser: Identifiable, Decodable {
    let id: String?
    let username: String
    let fullname: String
    let profileImageUrl: String
    let email: String
    
    init?(_ document: [String: Any]) {
        guard let id = document["uid"] as? String,
              let username = document["username"] as? String,
              let fullname = document["fullname"] as? String,
              let profileImageUrl = document["profileImage"] as? String,
              let email = document["email"] as? String else { return nil }
        
        self.id = id
        self.username = username
        self.fullname = fullname
        self.profileImageUrl = profileImageUrl
        self.email = email
    }
}
