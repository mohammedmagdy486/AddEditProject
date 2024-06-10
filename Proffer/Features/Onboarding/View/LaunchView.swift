//
import SwiftUI

struct LaunchView: View {

    @State private var splashUpOffset: CGFloat = -UIScreen.main.bounds.height / 2 - 50 // Start above the screen
    @State private var splashDownOffset: CGFloat = UIScreen.main.bounds.height / 2 + 50 // Start below the screen
    @State private var isLoading: Bool = false

    var body: some View {
        ZStack {
            Color(Asset.mainBGColor.name)
            Image(Asset.splashUp.name)
                .offset(x: 0, y: splashUpOffset)
                .onAppear {
                    withAnimation(.linear(duration: 1)) {
                        splashUpOffset += 250 // Move down by 50 points
                    }
                }

            Spacer()

            Image(Asset.logo.name)

            Spacer()

            Image(Asset.splashDown.name)
                .offset(x: 0, y: splashDownOffset)
                .onAppear {
                    withAnimation(.linear(duration: 1)) {
                        splashDownOffset -= 250 // Move up by 50 points
                    }
                }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            DispatchQueue.main.async {
                self.isLoading = true
            }

            // Additional logic to reset language and manage navigation
            GenericUserDefault.shared.setValue(true, Constants.shared.resetLanguage)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                MOLH.reset()
            }
        }
    }

    // Existing functions...
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
