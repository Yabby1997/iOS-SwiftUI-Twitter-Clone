//
//  CustomTextField.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/25.
//

import SwiftUI

struct CustomTextField: View {
    let imageName: String
    let placeholderText: String
    let isSecured: Bool
    @Binding var text: String
    
    init(imageName: String, placeholderText: String, isSecured: Bool = false, text: Binding<String>) {
        self.imageName = imageName
        self.placeholderText = placeholderText
        self.isSecured = isSecured
        self._text = text
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: self.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                
                if self.isSecured {
                    SecureField(self.placeholderText, text: self.$text)
                } else {
                    TextField(self.placeholderText, text: self.$text)
                }
            }
            Divider()
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(imageName: "heart.fill", placeholderText: "heart", text: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
