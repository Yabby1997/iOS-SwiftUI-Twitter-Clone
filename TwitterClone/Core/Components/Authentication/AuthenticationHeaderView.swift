//
//  AuthenticationHeaderView.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/27.
//

import SwiftUI

struct AuthenticationHeaderView: View {
    let title: String
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(self.title)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    Spacer()
                }
                
            }
            .frame(height: 260)
            .padding(.leading)
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(RoundedShape(width: 80, corners: .bottomRight))
        }
    }
}

struct AuthenticationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationHeaderView(title: "hello.\nseunghun")
    }
}
