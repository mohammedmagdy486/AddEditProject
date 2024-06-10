// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal static let calendarIcon = ImageAsset(name: "calendarIcon")
  internal static let checkMarkBlack = ImageAsset(name: "checkMarkBlack")
  internal static let checkMarkOrange = ImageAsset(name: "checkMarkOrange")
  internal static let checkMarkOrangeFill = ImageAsset(name: "checkMarkOrangeFill")
  internal static let editPen = ImageAsset(name: "editPen")
  internal static let getLocationIcon = ImageAsset(name: "getLocationIcon")
  internal static let multiplyDelete = ImageAsset(name: "multiplyDelete")
  internal static let uploadFileIcon = ImageAsset(name: "uploadFileIcon")
  internal static let logo = ImageAsset(name: "Logo")
  internal static let reload = ImageAsset(name: "Reload")
  internal static let forgetPassPopUpBackImage = ImageAsset(name: "forgetPassPopUpBackImage")
  internal static let exclamation = ImageAsset(name: "Exclamation")
  internal static let filter = ImageAsset(name: "Filter")
  internal static let star2 = ImageAsset(name: "Star 2")
  internal static let call = ImageAsset(name: "call")
  internal static let currency = ImageAsset(name: "currency")
  internal static let popUp = ImageAsset(name: "popUp")
  internal static let roomArea = ImageAsset(name: "roomArea")
  internal static let starLarge = ImageAsset(name: "starLarge")
  internal static let workSample = ImageAsset(name: "work-sample")
  internal static let mainBGColor = ColorAsset(name: "MainBGColor")
  internal static let mainOrangeColor = ColorAsset(name: "MainOrangeColor")
  internal static let secondBlueColor = ColorAsset(name: "SecondBlueColor")
  internal static let blackTitles = ColorAsset(name: "blackTitles")
  internal static let confirmBtnBG = ColorAsset(name: "confirmBtnBG")
  internal static let darkPink = ColorAsset(name: "darkPink")
  internal static let dividerColor = ColorAsset(name: "dividerColor")
  internal static let extraLightGray = ColorAsset(name: "extraLightGray")
  internal static let gray = ColorAsset(name: "gray")
  internal static let lightGray = ColorAsset(name: "lightGray")
  internal static let secondaryBGColor = ColorAsset(name: "secondaryBGColor")
  internal static let statusAccept = ColorAsset(name: "statusAccept")
  internal static let tabBar = ColorAsset(name: "tabBar")
  internal static let textFieldBGColor = ColorAsset(name: "textFieldBGColor")
  internal static let textGray = ColorAsset(name: "textGray")
  internal static let white = ColorAsset(name: "white")
  internal static let completeProfileIcon = ImageAsset(name: "completeProfileIcon")
  internal static let currentPage = ImageAsset(name: "currentPage")
  internal static let emptyState = ImageAsset(name: "emptyState")
  internal static let notification = ImageAsset(name: "notification")
  internal static let otherPage = ImageAsset(name: "otherPage")
  internal static let client = ImageAsset(name: "Client")
  internal static let contractor = ImageAsset(name: "Contractor")
  internal static let backBtn = ImageAsset(name: "backBtn")
  internal static let laugh = ImageAsset(name: "laugh")
  internal static let onBoardingImage = ImageAsset(name: "onBoardingImage")
  internal static let popUpBackView = ImageAsset(name: "popUpBackView")
  internal static let popUpRectangle = ImageAsset(name: "popUpRectangle")
  internal static let popUpXView = ImageAsset(name: "popUpXView")
  internal static let profilePlaceHolder = ImageAsset(name: "ProfilePlaceHolder")
  internal static let editProfileIcon = ImageAsset(name: "editProfileIcon")
  internal static let bathTub = ImageAsset(name: "bathTub")
  internal static let cell = ImageAsset(name: "cell")
  internal static let dataPoint = ImageAsset(name: "dataPoint")
  internal static let electricOutlet = ImageAsset(name: "electricOutlet")
  internal static let floor = ImageAsset(name: "floor ")
  internal static let roomDetailShadow = ImageAsset(name: "roomDetailShadow")
  internal static let routerDevice = ImageAsset(name: "routerDevice")
  internal static let thermostat = ImageAsset(name: "thermostat")
  internal static let toiletCapinet = ImageAsset(name: "toiletCapinet")
  internal static let walls = ImageAsset(name: "walls")
  internal static let waterHeater = ImageAsset(name: "waterHeater")
  internal static let waterMixer = ImageAsset(name: "waterMixer")
  internal static let waterSink = ImageAsset(name: "waterSink")
  internal static let bids = ImageAsset(name: "bids")
  internal static let bidsSelected = ImageAsset(name: "bidsSelected")
  internal static let home = ImageAsset(name: "home")
  internal static let homeSelected = ImageAsset(name: "homeSelected")
  internal static let more = ImageAsset(name: "more")
  internal static let moreSelected = ImageAsset(name: "moreSelected")
  internal static let projects = ImageAsset(name: "projects")
  internal static let projectsSelected = ImageAsset(name: "projectsSelected")
  internal static let faqCircle = ImageAsset(name: "FAQCircle")
  internal static let language = ImageAsset(name: "Language")
  internal static let aboutUs = ImageAsset(name: "aboutUs")
  internal static let backTransparent = ImageAsset(name: "backTransparent")
  internal static let bigBell = ImageAsset(name: "bigBell")
  internal static let contactUs = ImageAsset(name: "contactUs")
  internal static let detailsArrow = ImageAsset(name: "detailsArrow")
  internal static let faq = ImageAsset(name: "faq")
  internal static let logOut = ImageAsset(name: "logOut")
  internal static let pendingProjects = ImageAsset(name: "pendingProjects")
  internal static let privacy = ImageAsset(name: "privacy")
  internal static let profile = ImageAsset(name: "profile")
  internal static let resetPassword = ImageAsset(name: "reset-password")
  internal static let sadAction = ImageAsset(name: "sadAction")
  internal static let setting = ImageAsset(name: "setting")
  internal static let settingNotification = ImageAsset(name: "settingNotification")
  internal static let shadow = ImageAsset(name: "shadow")
  internal static let terms = ImageAsset(name: "terms")
  internal static let unReadDot = ImageAsset(name: "unReadDot")
  internal static let verySadAction = ImageAsset(name: "verySadAction")
  internal static let addAr = ImageAsset(name: "addAr")
  internal static let addEn = ImageAsset(name: "addEn")
  internal static let calendar = ImageAsset(name: "calendar")
  internal static let cancelIcon = ImageAsset(name: "cancelIcon")
  internal static let clock = ImageAsset(name: "clock")
  internal static let currencySmall = ImageAsset(name: "currencySmall")
  internal static let doneIcon = ImageAsset(name: "doneIcon")
  internal static let emoticon = ImageAsset(name: "emoticon")
  internal static let emptyStar = ImageAsset(name: "emptyStar")
  internal static let homeNotFill = ImageAsset(name: "homeNotFill")
  internal static let inprogressIcon = ImageAsset(name: "inprogressIcon")
  internal static let location = ImageAsset(name: "location")
  internal static let loveEmoji = ImageAsset(name: "loveEmoji")
  internal static let pendingIcon = ImageAsset(name: "pendingIcon")
  internal static let phone = ImageAsset(name: "phone")
  internal static let privateProjects = ImageAsset(name: "privateProjects")
  internal static let publicProjects = ImageAsset(name: "publicProjects")
  internal static let star = ImageAsset(name: "star")
  internal static let successfulLogo = ImageAsset(name: "successfulLogo")
  internal static let verySad = ImageAsset(name: "verySad")
  internal static let splashDown = ImageAsset(name: "SplashDown")
  internal static let splashUp = ImageAsset(name: "splashUp")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
