//
//  ProfferApp.swift
//  Proffer
//
//  Created by Mohammed Magdy on 4/11/23.
//  Copyright © 2024 Nura. All rights reserved.
//

import UIKit
import SwiftUI
import IQKeyboardManagerSwift
import FirebaseCore


@main
class AppDelegate: UIResponder, UIApplicationDelegate,MOLHResetable {
    
    var window: UIWindow?
    var authViewModel: AuthViewModel = AuthViewModel()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

        setUpDidFinishLaunch()
        
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("applicationDidBecomeActive")
        
    }
    
    func setUpDidFinishLaunch() {
        // Keyboard setup
        IQKeyboardManager.shared.enable = true
        languageConfiguration()
        self.reset()
    }
    
    func languageConfiguration() {
        MOLHLanguage.setDefaultLanguage("en") // Defult Language
        MOLH.shared.activate(true)
    }
    
    func reset() {
        NotificationConfigration.shared.firebaseConfigration()
        let window = UIWindow()
        self.window = window
        let resetLanguage = GenericUserDefault.shared.getValue(Constants.shared.resetLanguage) as? Bool ?? false
        let token = GenericUserDefault.shared.getValue(Constants.shared.token) as? String ?? ""
        let registerFinish = GenericUserDefault.shared.getValue(Constants.shared.registerFinish) as? Bool ?? true

        if resetLanguage == false {
            window.rootViewController = UIHostingController(rootView: LaunchView() .environment(\.locale, Locale(identifier: Constants.shared.isAR ? "ar":"en"))
                .environment(\.layoutDirection, Constants.shared.isAR ? .rightToLeft:.leftToRight))
        }
        else if token == "" {
            authViewModel.validateLogin(email: "pborer@example.net", password: "12345678")
        } // for test in gitHub only
        
        else if token != ""  {
            window.rootViewController = UIHostingController(rootView: AddProjectViewStep1(isEdit: false).environment(\.locale, Locale(identifier: Constants.shared.isAR ? "ar":"en"))
                .environment(\.layoutDirection, Constants.shared.isAR ? .rightToLeft:.leftToRight))
            UserDefaults.standard.set(false, forKey:  Constants.shared.resetLanguage)
            
        }
//        else  if registerFinish{
//        window.rootViewController = UIHostingController(rootView: OnBoardingView().environment(\.locale, Locale(identifier: Constants.shared.isAR ? "ar":"en"))
//            .environment(\.layoutDirection, Constants.shared.isAR ? .rightToLeft:.leftToRight))
//    
//        UserDefaults.standard.set(false, forKey:  Constants.shared.resetLanguage)
//        }
        
            window.makeKeyAndVisible()
        
        
    }
}

struct ProfferApp: App {
    var body: some Scene {
        WindowGroup {
            if Constants.shared.isAR {
                ContentView()
                    .environment(\.locale, Locale(identifier: "ar"))
                    .environment(\.layoutDirection, .rightToLeft)
            }else{
                ContentView()
                    .environment(\.locale, Locale(identifier: "en"))
                    .environment(\.layoutDirection, .leftToRight)
            }        }
    }
}
