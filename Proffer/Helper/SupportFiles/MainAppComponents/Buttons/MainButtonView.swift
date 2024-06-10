//
//  YellowButtonView.swift
//  Proffer
//
//  Created by M.Magdy on 18/02/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import SwiftUI
enum ButtonColors {
    case blue
    case orange
    case transparent
}
struct MainButtonView: View {
    @State var buttonTitle:String
    @State var buttonColor: ButtonColors
    @State var titleSize: CGFloat = 18
    @State var width: CGFloat = 220
    @State var height: CGFloat = 48
    @State var radius: CGFloat = 24
    var body: some View {
            HStack {
                Spacer()
                Text(buttonTitle)
                    .font(.custom(AppFonts.shared.name(AppFontsTypes.regular), size: titleSize))
                    .foregroundStyle(buttonColor == .transparent ? Color(Asset.mainOrangeColor.name): Color(.white))
                    .frame(height: height)
                Spacer()
            }
            .frame(height: height)
            .background(Color(buttonColor == .orange ? (Asset.mainOrangeColor.name) : (buttonColor == .blue ? Asset.secondBlueColor.name : Asset.white.name) ))
            .overlay(RoundedRectangle(cornerRadius: radius)
                .stroke(Color.init(buttonColor == .blue ? (Asset.secondBlueColor.name) : (Asset.mainOrangeColor.name)), lineWidth: 1))
            .frame(width: width)
            .cornerRadius(radius)
            
        
    }
}

#Preview {
    MainButtonView(buttonTitle: "Ttile", buttonColor: .transparent)
}
