//
//  TweetRowView.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/20.
//

import SwiftUI

struct TweetRowView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top, spacing: 12) {
                    Circle()
                        .frame(width: 56, height: 56)
                        .foregroundColor(Color(.systemBlue))
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Seunghun Yang")
                                .font(.subheadline).bold()
                            Text("@yabby1997")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("2w")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Text("SwiftUI 재밌어~")
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                    }
                }
                HStack {
                    Button {
                        print("Hello")
                    } label: {
                        Image(systemName: "bubble.left")
                            .font(.subheadline)
                    }
                    Spacer()
                    Button {
                        print("Hello")
                    } label: {
                        Image(systemName: "arrow.2.squarepath")
                            .font(.subheadline)
                    }
                    Spacer()
                    Button {
                        print("Hello")
                    } label: {
                        Image(systemName: "heart")
                            .font(.subheadline)
                    }
                    Spacer()
                    Button {
                        print("Hello")
                    } label: {
                        Image(systemName: "bookmark")
                            .font(.subheadline)
                    }
                }
                .padding()
                .foregroundColor(.gray)
            }
            .padding()
            Divider()
        }
    }
}

struct TweetRowView_Previews: PreviewProvider {
    static var previews: some View {
        TweetRowView()
            .previewLayout(.sizeThatFits)
    }
}
