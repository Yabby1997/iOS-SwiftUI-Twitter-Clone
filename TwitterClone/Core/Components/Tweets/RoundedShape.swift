//
//  RoundedShape.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/25.
//

import SwiftUI

struct RoundedShape: Shape {
    let width: CGFloat
    let corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: self.corners, cornerRadii: CGSize(width: self.width, height: self.width))
        return Path(path.cgPath)
    }
}
