//
//  TwitterUser.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/02/02.
//

import FirebaseFirestoreSwift
import Firebase

struct TwitterUser: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let profileImage: String
    let email: String
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == self.id }
}
