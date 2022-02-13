//
//  FeedView.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/20.
//

import SwiftUI

struct FeedView: View {
    @State private var showNewTwitView: Bool = false
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                LazyVStack {
                    ForEach(self.viewModel.twits) { twit in
                        twitRowView(twit: twit)
                    }
                }
            }
            Button {
                self.showNewTwitView.toggle()
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
        .fullScreenCover(isPresented: $showNewTwitView) {
            NewTwitView()
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
