//
//  Constants.swift
//
//  Created by Mohammed Magdy on 4/11/23.
//  Copyright © 2024 Nura. All rights reserved.
//

import Foundation
class Constants {
    static var shared = Constants()

    
    var isAR: Bool { return (MOLHLanguage.currentAppleLanguage() == "ar") }
    let baseURL =  "https://backend.profferdeals.com/api/"  // https://insta-integration.appssquare.com/api/ develop instance
//    let baseURL =   "" // live
//    appStoreId https://apps.apple.com/app/id
    let developerMode = false
    let resetLanguage = "resetLanguage"
    var onboarding = "onboarding"
    let token = ""
    let returnCode = "returnCode"
    let userName = "userName"
    let registerFinish  = "No"
    let phone = "phone"
    let email = "email"
    let gender = "gender"
    let dateOfBirth = "dateOfBirth"
    let profileImageURL = "profileImageURL"
    let deviceToken = "deviceToken"
    let unReadNotificationCount = "unread"
    let notificationOnOrOff = "notificationOnOrOff"
    let userType = "userType"
    let needsVerification = "needVerification"
    let isFirstLogin = "isFirstLogin"

}
