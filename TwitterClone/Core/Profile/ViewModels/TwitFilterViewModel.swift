//
//  TwitFilterViewModel.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/21.
//

import Foundation

enum TweetFilterViewModel: Int, CaseIterable {
    case tweets, replies, likes
    
    var title: String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Replies"
        case .likes: return "Likes"
        }
    }
}
