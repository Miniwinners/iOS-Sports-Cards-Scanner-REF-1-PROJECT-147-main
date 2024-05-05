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
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Images {
    internal static let addToPortfolio = ImageAsset(name: "addToPortfolio")
    internal static let addSet = ImageAsset(name: "addSet")
    internal static let appleLogo = ImageAsset(name: "appleLogo")
    internal static let backArrow = ImageAsset(name: "backArrow")
    internal static let bottomArrow = ImageAsset(name: "bottomArrow")
    internal static let cardCheck = ImageAsset(name: "cardCheck")
    internal static let cardNocards = ImageAsset(name: "cardNocards")

    internal enum CardsDisplay {
        internal static let collection = ImageAsset(name: "cardsDisplay/collection")
        internal static let list = ImageAsset(name: "cardsDisplay/list")
        internal static let swipable = ImageAsset(name: "cardsDisplay/swipable")
    }
    internal enum CardsLogo {
        internal static let footBall = ImageAsset(name: "footBall")
        internal static let basketBall = ImageAsset(name: "basketBall")
        internal static let baseBall = ImageAsset(name: "baseBall")
        internal static let soccer = ImageAsset(name: "soccer")
        internal static let hockey = ImageAsset(name: "hockey")
    }
    internal static let checkSign = ImageAsset(name: "checkSign")
    internal static let checked = ImageAsset(name: "checked")
    internal static let clear = ImageAsset(name: "clear")
    internal static let close = ImageAsset(name: "close")
    internal static let collection = ImageAsset(name: "collection")
    internal enum CollectionMenu {
        internal static let addCards = ImageAsset(name: "collectionMenu/addCards")
        internal static let deleteCollection = ImageAsset(name: "collectionMenu/deleteCollection")
        internal static let removeCards = ImageAsset(name: "collectionMenu/removeCards")
        internal static let renameCollection = ImageAsset(name: "collectionMenu/renameCollection")
        internal static let sortCards = ImageAsset(name: "collectionMenu/sortCards")
    }
    internal static let dashboard = ImageAsset(name: "dashboard")
    internal static let dashboardSelected = ImageAsset(name: "dashboardSelected")
    internal static let deck = ImageAsset(name: "deck")
    internal static let deckSign = ImageAsset(name: "deckSign")
    internal static let disclose = ImageAsset(name: "disclose")
    internal static let disclosure = ImageAsset(name: "disclosure")
    internal static let disclosureBottom = ImageAsset(name: "disclosureBottom")
    internal static let dollar = ImageAsset(name: "dollar")
    internal static let edit = ImageAsset(name: "edit")
    internal static let forwardArrow = ImageAsset(name: "forwardArrow")
    internal static let forwardArrowWhite = ImageAsset(name: "forwardArrowWhite")
    internal static let facebookLogo = ImageAsset(name: "facebookLogo")
    internal static let googleLogo = ImageAsset(name: "googleLogo")
    internal static let highValue1 = ImageAsset(name: "highValue1")
    internal static let highValue2 = ImageAsset(name: "highValue2")
    internal static let highValue3 = ImageAsset(name: "highValue3")

    internal static let loadingIndicator = ImageAsset(name: "loadingIndicator")
    internal static let menuDots = ImageAsset(name: "menuDots")
    internal static let more = ImageAsset(name: "more")
    internal static let moreSelected = ImageAsset(name: "moreSelected")
    internal static let portfolio = ImageAsset(name: "portfolio")
    internal static let portfolioSelected = ImageAsset(name: "portfolioSelected")
    internal static let profileLogo = ImageAsset(name: "profileLogo")
    internal static let remove = ImageAsset(name: "remove")
    internal static let reorder = ImageAsset(name: "reorder")
    internal static let scan = ImageAsset(name: "scan")
    internal static let scannerApp = ImageAsset(name: "scannerApp")
    internal static let search = ImageAsset(name: "search")
    internal static let validEmail = ImageAsset(name: "validEmail")
    internal static let unchecked = ImageAsset(name: "unchecked")
    internal static let lockLogo = ImageAsset(name: "lockLogo")
    internal static let unlockLogo = ImageAsset(name: "unlockLogo")
    internal static let loading = ImageAsset(name: "loading")
    internal static let addPlus = ImageAsset(name: "addPlus")
    internal static let addPlus2 = ImageAsset(name: "addPlus2")
    internal static let createDeck = ImageAsset(name: "createDeck")
    internal static let createCollection = ImageAsset(name: "createCollection")
    internal static let collectionCards = ImageAsset(name: "collectionCards")
    internal static let forwardArrowBlue = ImageAsset(name: "forwardArrowBlue")
    internal static let gradeStar = ImageAsset(name: "gradeStar")
    internal static let noConnection = ImageAsset(name: "noConnection")
    internal static let lock = ImageAsset(name: "lock")

    
    
    
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

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
