//
//  PopUpTitleView.swift
//  Proffer
//
//  Created by M.Magdy on 22/02/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import SwiftUI

struct PopUpTitleView: View {
    @State var image : String = ""
    @State var title :String = ""
    @State var subTitle:String = ""
    
    var body: some View {
            
            VStack {
                Image (image)
                   
                Text(title)
                    .font(.custom(AppFonts.shared.name(AppFontsTypes.bold), size: 27))
                    .foregroundStyle(Color(Asset.mainOrangeColor.name))
                    .padding(.bottom)
                Text(subTitle)
                .font(.custom(AppFonts.shared.name(AppFontsTypes.bold), size: 17))
                .foregroundStyle(Color(Asset.lightGray.name))
                .multilineTextAlignment(.center)
                .padding([.leading,.trailing],30)
                
                
            }
        

    }
}

#Preview {
    PopUpTitleView()
}
