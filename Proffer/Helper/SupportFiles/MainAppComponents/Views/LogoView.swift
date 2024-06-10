//
//  LogoView.swift
//  Proffer
//
//  Created by M.Magdy on 18/02/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import SwiftUI

struct LogoView: View {
    @State var title : String = ""
    @State var subTitle: String = ""
    var body: some View {
        VStack(spacing: 10) {
            Image(Asset.logo.name)
                .resizable()
                .frame(width: 183,height: 47)
            Text(title)
                .font(.custom(AppFonts.shared.name(AppFontsTypes.regular), size: 27))
                .foregroundStyle(Color(Asset.mainOrangeColor.name))
            Text(subTitle)
            .font(.custom(AppFonts.shared.name(AppFontsTypes.regular), size: 17))
            .foregroundStyle(Color(Asset.blackTitles.name))
        }
    }
}

#Preview {
    LogoView()
}
