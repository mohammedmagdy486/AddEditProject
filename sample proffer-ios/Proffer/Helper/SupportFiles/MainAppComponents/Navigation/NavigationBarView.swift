//
//  NavigationBarView.swift
//  Proffer
//
//  Created by M.Magdy on 18/02/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import SwiftUI

struct NavigationBarView: View {
    @State var title: String = ""
    @Binding var isBackTapped : Bool
    @State var color : Color = .black
    @State var withoutBack: Bool = false

    var body: some View {
        HStack {
            Button(action: {
                isBackTapped = true
            }, label: {
                Image(!withoutBack ? Asset.backBtn.name:"")
                    .resizable()
                    .frame(width: 37 ,height: 37)
                
            })
            Spacer()
            Text(title)
                .font(.custom(AppFonts.shared.name(AppFontsTypes.medium), size: 22))
                .foregroundStyle(Color(color))
            Spacer()
            Image("")
                .resizable()
                .frame(width: 37 ,height: 37)
            
        }

        .padding([.leading,.trailing])
        .padding(.bottom,20)
    }
}

#Preview {
    NavigationBarView( isBackTapped: .constant(true))
}
