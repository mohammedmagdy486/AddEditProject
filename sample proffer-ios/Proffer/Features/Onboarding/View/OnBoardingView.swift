//
//  OnBoarding1View.swift
//  Life Care
//
//  Created by AMN on 4/11/23.
//  Copyright © 2023  Nura. All rights reserved.
//

import SwiftUI

struct OnBoardingView: View {
    @State var isSignUpTapped:Bool = false
    @State var isLoginTapped:Bool = false
    @State var dismissPopUp: Bool = false
    @State var isClientTapped:Bool = false
    @State var isContractorTapped:Bool = false
    var body: some View {
        NavigationStack {
            ZStack {
               
                VStack(alignment: .center,spacing: 10){
                    LogoView()
                        .padding(.top,20)
                    Image(Asset.onBoardingImage.name)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 80 ,height: UIScreen.main.bounds.height * 0.4)
                        
                    Text("Build Your House".localized())
                        .font(.custom(AppFonts.shared.name(AppFontsTypes.bold), size: 28))
                        .foregroundStyle(Color(Asset.mainOrangeColor.name))
                    VStack(spacing: 0) {
                        Text("Personalize your experience and".localized())
                            .font(.custom(AppFonts.shared.name(AppFontsTypes.bold), size: 16))
                            .foregroundStyle(Color(Asset.blackTitles.name))
                        Text("Get exclusive offers".localized())
                            .font(.custom(AppFonts.shared.name(AppFontsTypes.bold), size: 16))
                            .foregroundStyle(Color(Asset.blackTitles.name))
                    }
                    
                    HStack {
                        Spacer()
                        Button {
                           isLoginTapped = true
                        } label: {
                            MainButtonView(buttonTitle: "Login".localized(), buttonColor: .blue,width: 150)
                                .navigationDestination(isPresented: $isLoginTapped) {
//                                    LoginView()
                                }
                        }
                        .padding(.trailing,-15)
                        
                        Spacer()

                        Button {
                            isSignUpTapped = true
                        }label: {
                            MainButtonView(buttonTitle: "Sign Up".localized(), buttonColor: .orange, width: 150)
                        }
                        .padding(.leading,-15)
                        
                        Spacer()
                    }
                    .padding(.top,30)
//                    .padding(.bottom,20)
                    Spacer()
                }
                .background(Color(Asset.mainBGColor.name))
                .onTapGesture {
                    dismissPopUp = true
                }
                if (isSignUpTapped == true && dismissPopUp == false) {
                    ZStack {
                        PopUpViewBack(isXTapped: $dismissPopUp)
                        VStack {
                            Text("Define yourself".localized())
                                .font(.custom(AppFonts.shared.name(AppFontsTypes.bold), size: 27))
                                .foregroundStyle(Color(Asset.mainOrangeColor.name))
                                .padding(.top,30)
                            Text("Create your account based \n on your identity".localized())
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .font(.custom(AppFonts.shared.name(AppFontsTypes.bold), size: 17))
                                .foregroundStyle(Color(Asset.blackTitles.name))
                            ZStack {
                                VStack {
                                    Spacer()
                                    Button  {
                                        isClientTapped = true
                                    } label: {
                                        VStack {
                                            Image(Asset.client.name)
                                               
                                            Text("Client".localized())
                                                .font(.custom(AppFonts.shared.name(AppFontsTypes.bold), size: 17))
                                                .foregroundStyle(Color(Asset.blackTitles.name))
                                        }
                                        .navigationDestination(isPresented: $isClientTapped) {
//                                            SignUPView(userType: .client)
                                        }
                                    }
                                    Spacer()
                                }
                            }
                            .frame(width: 227,height: 117)
                            .background(Color(Asset.mainBGColor.name))
                            .cornerRadius(15)
                            
                            ZStack {
                                VStack {
                                    Spacer()
                                    Button {
                                        isContractorTapped = true
                                    } label: {
                                        VStack {
                                               Image(Asset.contractor.name)
                                                Text("Contractor".localized())
                                                    .font(.custom(AppFonts.shared.name(AppFontsTypes.bold), size: 17))
                                                    .foregroundStyle(Color(Asset.blackTitles.name))
                                            }
                                        .navigationDestination(isPresented: $isContractorTapped) {
//                                            SignUPView(userType: .contractor)
                                    }

                                    
                                    }
                                    Spacer()
                                    
                                }
                                
                            }
                            .frame(width: 227,height: 117)
                            .background(Color(Asset.mainBGColor.name))
                            .cornerRadius(15)
                            Spacer()
                        }
                        .frame(height: UIScreen.main.bounds.height * 0.6)

                        .onDisappear{
                            isSignUpTapped = false
                            dismissPopUp = false
                        }
                        
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.8)
                }
            }
        }
    }
}

struct OnBoarding1View_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
