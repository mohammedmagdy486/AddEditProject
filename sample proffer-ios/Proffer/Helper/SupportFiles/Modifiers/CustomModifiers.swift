//Proffer
//CustomModifiers.swift

//  Created by Mohammed Magdy on 4/11/23.

import SwiftUI

extension View {
    func textModifier(_ type: AppFontsTypes, _ size: CGFloat, _ color: Color) -> some View {
        self
            .font(.custom(AppFonts.shared.name(type), size: size))
            .foregroundStyle(color)
    }
}
