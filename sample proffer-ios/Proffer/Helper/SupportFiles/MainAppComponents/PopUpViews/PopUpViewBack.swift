//
//  PopUpViewBack.swift
//  Proffer
//
//  Created by M.Magdy on 19/02/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import SwiftUI

struct PopUpViewBack: View {
    @Binding var isXTapped:Bool
    var body: some View {
        VStack(spacing: 0) {
            Image(Asset.popUpBackView.name)
                .shadow(radius: 10)
            Button{
               isXTapped = true
            } label: {
                Image(Asset.popUpXView.name)
                    .shadow(radius: 5)
            }
            

        }
    }
}

#Preview {
    PopUpViewBack(isXTapped: .constant(false))
}
