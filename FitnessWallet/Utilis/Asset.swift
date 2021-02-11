//
//  Asset.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 06/01/2021.
//

import Foundation

#if os(OSX)
import AppKit.NSImage
internal typealias AssetColorTypeAlias = NSColor
internal typealias AssetImageTypeAlias = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
import UIKit.UIImage
internal typealias AssetColorTypeAlias = UIColor
internal typealias AssetImageTypeAlias = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name

internal enum Asset {
    internal static let eye_slash_fill = ImageAsset(name: "eye.slash.fill")
    internal static let eye_fill = ImageAsset(name: "eye.fill")
    internal static let infoImage = ImageAsset(name: "info.circle")
    internal static let venomImage = ImageAsset(name: "venom-7")
    internal static let instagramImage = ImageAsset(name: "Instagram_logo_white")
    internal static let comment = ImageAsset(name: "comment")
    internal static let gear = ImageAsset(name: "gear")
    internal static let grid = ImageAsset(name: "grid")
    internal static let list = ImageAsset(name: "list")
    internal static let send = ImageAsset(name: "send2")
    internal static let plusPhoto = ImageAsset(name: "plus_photo")
    internal static let plus_unselected = ImageAsset(name: "plus_unselected")
    internal static let profile_selected = ImageAsset(name: "profile_selected")
    internal static let profile_unselected = ImageAsset(name: "profile_unselected")
    internal static let home_selected = ImageAsset(name: "home_selected")
    internal static let home_unselected = ImageAsset(name: "home_unselected")
    internal static let like_selected = ImageAsset(name: "like_selected")
    internal static let like_unselected = ImageAsset(name: "like_unselected")
    internal static let ribbon = ImageAsset(name: "ribbon")
    internal static let search_selected = ImageAsset(name: "search_selected")
    internal static let search_unselected = ImageAsset(name: "search_unselected")
    internal static let upload_image_icon = ImageAsset(name: "upload_image_icon")
    internal static let dollarsign_circle = ImageAsset(name: "dollarsign.circle")
    internal static let pencil_and_ellipsis = ImageAsset(name: "pencil.and.ellipsis.rectangle")
    internal static let flame = ImageAsset(name: "flame")
    internal static let chart_pie = ImageAsset(name: "chart.pie")
}

// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ColorAsset {
    internal fileprivate(set) var name: String
    
    @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
    internal var color: AssetColorTypeAlias {
        return AssetColorTypeAlias(asset: self)
    }
}

internal extension AssetColorTypeAlias {
    @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
    convenience init!(asset: ColorAsset) {
        let bundle = Bundle(for: BundleToken.self)
        #if os(iOS) || os(tvOS)
        self.init(named: asset.name, in: bundle, compatibleWith: nil)
        #elseif os(OSX)
        self.init(named: NSColor.Name(asset.name), bundle: bundle)
        #elseif os(watchOS)
        self.init(named: asset.name)
        #endif
    }
}

internal struct ImageAsset {
    internal fileprivate(set) var name: String
    
    internal var image: AssetImageTypeAlias {
        let bundle = Bundle(for: BundleToken.self)
        #if os(iOS) || os(tvOS)
        let image = AssetImageTypeAlias(named: name, in: bundle, compatibleWith: nil)
        #elseif os(OSX)
        let image = bundle.image(forResource: NSImage.Name(name))
        #elseif os(watchOS)
        let image = AssetImageTypeAlias(named: name)
        #endif
        guard let result = image else { fatalError("Unable to load image named \(name).") }
        return result
    }
}

internal extension AssetImageTypeAlias {
    @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
    @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
    convenience init!(asset: ImageAsset) {
        #if os(iOS) || os(tvOS)
        let bundle = Bundle(for: BundleToken.self)
        self.init(named: asset.name, in: bundle, compatibleWith: nil)
        #elseif os(OSX)
        self.init(named: NSImage.Name(asset.name))
        #elseif os(watchOS)
        self.init(named: asset.name)
        #endif
    }
}

private final class BundleToken {}

