//
//  TextModifier.swift
//  ToughCookie
//
//  Created by 이중엽 on 5/27/24.
//

import SwiftUI

struct TextModifier: ViewModifier {
    
    let fontSize: CGFloat
    let textColor: Color
    
    func body(content: Content) -> some View {
        
        content
            .font(.system(size: fontSize))
            .foregroundStyle(textColor)
    }
}

extension View {
    
    func asDefaultText(fontSize: CGFloat, textColor: Color) -> some View {
        modifier(TextModifier(fontSize: fontSize, textColor: textColor))
    }
}
