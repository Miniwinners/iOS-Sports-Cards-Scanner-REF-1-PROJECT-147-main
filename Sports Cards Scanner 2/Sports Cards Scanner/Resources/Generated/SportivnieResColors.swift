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

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum SportivinieKartiCveta {
  internal static let actionActiveColor = ColorAsset(name: "actionActiveColor")
  internal static let actionInactiveColor = ColorAsset(name: "actionInactiveColor")
  internal static let backColor = ColorAsset(name: "backColor")
  internal static let barColor = ColorAsset(name: "barColor")
  internal static let barTintColor = ColorAsset(name: "barTintColor")
  internal static let blackColor40 = ColorAsset(name: "blackColor40")
  internal static let cardBackColor = ColorAsset(name: "cardBackColor")
  internal static let baseball = ColorAsset(name: "baseball")
  internal static let basketball = ColorAsset(name: "basketball")
  internal static let football = ColorAsset(name: "football")
  internal static let hockey = ColorAsset(name: "hockey")
  internal static let magic = ColorAsset(name: "magic")
  internal static let pokemon = ColorAsset(name: "pokemon")
  internal static let soccer = ColorAsset(name: "soccer")
  internal static let darkBackColor = ColorAsset(name: "darkBackColor")
  internal static let destructiveColor = ColorAsset(name: "destructiveColor")
  internal static let dividerColor = ColorAsset(name: "dividerColor")
  internal static let errorColor = ColorAsset(name: "errorColor")
  internal static let fillColor = ColorAsset(name: "fillColor")
  internal static let greenColor = ColorAsset(name: "greenColor")
  internal static let highlightColor = ColorAsset(name: "highlightColor")
  internal static let highlightColor2 = ColorAsset(name: "highlightColor2")
  internal static let labelColor = ColorAsset(name: "labelColor")
  internal static let labelColor2 = ColorAsset(name: "labelColor2")
  internal static let labelColor3 = ColorAsset(name: "labelColor3")
  internal static let labelColor4 = ColorAsset(name: "labelColor4")
  internal static let secondaryColor = ColorAsset(name: "secondaryColor")
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
  internal func cvet(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let cvet = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return cvet
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
