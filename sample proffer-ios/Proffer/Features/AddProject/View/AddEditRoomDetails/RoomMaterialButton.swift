//
//  RoomMaterialButton.swift
//  Proffer
//
//  Created by M.Magdy on 27/05/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import SwiftUI

struct RoomMaterialButton :View {
    @State var image:String?
    @State var name:String?
    @Binding var material: RealMaterialsData?
    
    var body: some View {
        VStack(spacing: 0) {
            if material != nil {
                HStack {
                    Text(name?.localized() ?? "")
                        .textModifier(.regular, 14, .blackTitles)
                    Spacer()
                }
                .frame(width: (UIScreen.main.bounds.width - 60)/3)
            }
            ZStack {
                Image(image ?? "")
                    .resizable()
                    .frame(width: (UIScreen.main.bounds.width - 60)/3,height: 95)
                VStack {
                    Spacer()
                    if material == nil {
                        Text(name ?? "")
                            .textModifier(.regular, 14, .white)
                            .padding(.bottom,10)
                    }
                    else {
                        Text(material?.name ?? "")
                            .textModifier(.regular, 14, .white)
                        Text(String(format: "%.1f", material?.price ?? 0) + " LE".localized())
                            .textModifier(.regular, 14, .white)
                            .padding(.bottom,10)
                    }
                }
                .cornerRadius(11)
            }
        }
    }
}

//#Preview {
//    RoomMaterialButton()
//}
