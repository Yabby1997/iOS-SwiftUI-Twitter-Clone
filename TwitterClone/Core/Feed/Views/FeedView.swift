//
//  FeedView.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/20.
//

import SwiftUI

struct FeedView: View {
    @State private var showNewTweetView: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                LazyVStack {
                    ForEach(0...20, id: \.self) { _ in
                        TweetRowView()
                    }
                }
            }
            Button {
                self.showNewTweetView.toggle()
            } label: {
                ZStack {
                    Circle()
                    Image(systemName: "pencil.and.outline")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .frame(width: 70, height: 70)
                .padding()
            }
        }
        .fullScreenCover(isPresented: $showNewTweetView) {
            NewTweetView()
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
