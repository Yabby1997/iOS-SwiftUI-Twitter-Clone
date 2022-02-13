//
//  TwitFilterViewModel.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/21.
//

import Foundation

enum TwitFilterViewModel: Int, CaseIterable {
    case twits, replies, likes
    
    var title: String {
        switch self {
        case .twits: return "Twits"
        case .replies: return "Replies"
        case .likes: return "Likes"
        }
    }
}
