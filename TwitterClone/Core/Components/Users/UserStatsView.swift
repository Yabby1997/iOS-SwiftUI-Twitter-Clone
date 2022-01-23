//
//  UserStatsView.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/23.
//

import SwiftUI

struct UserStatsView: View {
    var body: some View {
        HStack {
            HStack(spacing: 4) {
                Text("76")
                    .font(.subheadline).bold()
                Text("Following")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            HStack(spacing: 4) {
                Text("94")
                    .font(.subheadline).bold()
                Text("Followers")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct UserStatsView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatsView()
            .previewLayout(.sizeThatFits)
    }
}
