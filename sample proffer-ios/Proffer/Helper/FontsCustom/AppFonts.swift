//
//  AppFonts.swift
//
//
//  Created by Mohammed Magdy on 4/11/23.
//

import SwiftUI
enum AppFontsTypes: String {
    case bold = "Bold"
    case extraBold = "ExtraBold"
    case semiBold = "SemiBold"
    case medium = "Medium"
    case light = "Light"
    case extraLight = "ExtraLight"
    case regular = "Regular"
}
struct AppFonts {
    static let shared  = AppFonts()
    func name(_ type:AppFontsTypes) -> String {
        let fontName = Constants.shared.isAR ?"Cairo":"Poppins" + "-" + type.rawValue
            return fontName
    }
    
}
