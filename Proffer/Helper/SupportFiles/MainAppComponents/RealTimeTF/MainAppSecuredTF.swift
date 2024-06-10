//
//  MAinAppSecuredTF.swift
//  Proffer
//
//  Created by M.Magdy on 15/02/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import SwiftUI

struct MainAppSecuredTF: View {
    @Binding var text: String
    @State var title : String
    @State var placeHolder: String
    @State var validationType: validateFieldType
    @State  var submitLabel: SubmitLabel
    @State  var keyboardType: UIKeyboardType
    @State var isConfirmPassword:Bool = false
    @State var titleSize : CGFloat = 17
    @StateObject private var validateTF = ValidateTF()
    @State private var isSecure : Bool = true
    @Binding var confirmThisPassword: String
    var body: some View {
         VStack {
             HStack {
                 Text ("\(title)")
                     .font(.custom(AppFonts.shared.name(AppFontsTypes.semiBold), size: titleSize ))
                     .foregroundStyle(Color(Asset.blackTitles.name))
                 Spacer()
             }
             HStack{
                 if !isSecure  {
                     TextField("\(placeHolder)", text: $text)
                         .padding()
                         .textInputAutocapitalization(.never)
                         .autocorrectionDisabled()
                         .keyboardType(keyboardType)
                         .submitLabel(submitLabel)
                         .onChange(of: text) {  _,_ in
                             if isConfirmPassword {
                                 validateTF.confirmPassword(password: confirmThisPassword, confirmPassword: text)
                             }
                         }
                         .frame(height: 56)
                 }
                 else {
                     SecureField("\(placeHolder)", text: $text)
                         .padding()
                         .textInputAutocapitalization(.never)
                         .autocorrectionDisabled()
                         .frame(height: 56)
                         .keyboardType(keyboardType)
                         .submitLabel(submitLabel)
                         .onChange(of: text) {  _,_ in
                             if isConfirmPassword {
                                 validateTF.confirmPassword(password: confirmThisPassword, confirmPassword: text)
                             }
                         }
                 }
                 VStack {
                     Button(action: {
                         self.isSecure.toggle()
                         
                     }, label: {
                         Image(systemName: isSecure ? "eye.fill" : "eye.slash.fill")
                             .resizable()
                             .scaledToFit()
                             .frame(width: 20,height: 20)
                             .foregroundColor(Color(Asset.lightGray.color))
                             .padding(.trailing,9)
                             .opacity(0.7 )
                     })
                     
                 }
                 .frame(width: 15,height: 15)
                 .padding(.trailing, 20)
             }
             .background(Color(asset: Asset.textFieldBGColor))
             .cornerRadius(15)
             .shadow(radius: 1)
             .frame(maxWidth:.infinity,maxHeight: 56)
             
             HStack {
                 Text ("\(validateTF.errorMessage)")
                     .font(.custom(AppFonts.shared.name(AppFontsTypes.semiBold), size: 13 ))
                     .padding(.leading,5)
                     .foregroundStyle(Color.red)
                 
                 Spacer()
             }
             
         }
         .padding([.leading,.trailing])
         
     }
}

//#Preview {
//    MainAppSecuredTF(text: .constant(""),title:"Title",placeHolder:"Your Name", confirmThisPassword: .constant(""))
//}
