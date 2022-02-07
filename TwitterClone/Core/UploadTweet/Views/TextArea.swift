//
//  TextArea.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/24.
//

import SwiftUI

struct TextArea: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .padding(4)
            
            Text(self.text.isEmpty ? self.placeholder : "")
                .foregroundColor(Color(.placeholderText))
                .padding(.horizontal, 8)
                .padding(.vertical, 12)
                
        }
    }
}
