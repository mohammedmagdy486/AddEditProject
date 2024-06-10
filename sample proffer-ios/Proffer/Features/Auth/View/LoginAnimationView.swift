//
//  LoginAnimationView.swift
//  Proffer
//
//  Created by M.Magdy on 24/03/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import SwiftUI

struct LoginAnimationView: View {
    
    @State private var rectHeight: CGFloat = 76 // Initial width of the rectangle
    @State private var showLoader: Bool = false //
    @State private var isLoaderFinished: Bool = false
    @State private var email: String = ""
    
    var body: some View {
        ZStack {
            Color(.mainBG)
                .ignoresSafeArea(.all)
            Rectangle()
                .fill(Color.white) // White background
                .frame(width: UIScreen.main.bounds.width - 40 , height: rectHeight)
                .cornerRadius(10)
                .shadow(radius: 10)
            VStack {
                HStack {
                    Image(systemName: "logo.image") // Replace "logo.image" with your logo
                    Text("Title")
                        .textModifier(.regular, 32, .green)
                }
                .padding()
                
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width - 40 , height: rectHeight)
            
            // Loader
            if showLoader {
                CustomLoader()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.green)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.01) {
                            isLoaderFinished = true
                        }
                    }
            }
            if isLoaderFinished {
                VStack {
                    Spacer()
                    MainAppTF(text: $email, title: "email", placeHolder: "email", validationType: .email, submitLabel: .next, keyboardType: .emailAddress)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width - 40 , height: rectHeight)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.easeInOut(duration: 1.0)) {
                    self.rectHeight = 500
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.showLoader = true 
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.showLoader = false
                    }
                }
            }
        }
    }
}

struct AnimatedLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoginAnimationView()
    }
}
struct CustomLoader: View {
    @State private var isAnimating = false

    var body: some View {
        Circle()
            .trim(from: 0, to: 0.6) // Adjust trim values to match the look of your loader
            .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
            .onAppear {
                withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                    isAnimating = true
                }
            }
    }
}
