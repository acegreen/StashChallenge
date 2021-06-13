//
//  BundleHelper.swift
//  AGViperKit
//
//  Created by Ace Green on 6/12/21.
//

import Foundation
import UIKit

public class BundleHelper {

    /// Utility function that returns the named bundle found within the RecoverCoreUI framework bundle,
    /// falling back to return the framework bundle itself if the named bundle is not found.
    ///
    /// Note: Within the Xcode Framework environment, resources are found within the RecoverCoreUI bundle,
    /// however within the deployed RecoverCoreUI cocoapod environment, resources are organized and delivered
    /// within the RecoverCoreUIResources.bundle which resides inside the RecoverCoreUI framework bundle.
    ///
    /// - parameter name: The name of the bundle to return from within the RecoverCoreUI framework
    /// - returns: The named bundle found within the RecoverCoreUI framework bundle or the RecoverCoreUI
    ///            framework bundle itself. If the named bundle URL exists but the bundle cannot be
    ///            instantiated from the bundleURL, nil will be returned.
    public static func bundle(named name: String, for aClass: AnyClass? = nil) -> Bundle? {
        let frameworkBundle = Bundle(for: aClass ?? BundleHelper.self)
        guard let bundleURL = frameworkBundle.url(forResource: name, withExtension: "bundle") else {
            return frameworkBundle
        }
        return Bundle(url: bundleURL)
    }

    /// Returns the named UIColor from the asset catalog in the specified bundle.
    ///
    /// - Parameters:
    ///   - name: Name of a color in an asset catalog.
    ///   - bundle: Bundle the asset catalog belongs to.
    ///   - bundleName: Name of the bundle as substitutional parameter of Bundle.
    ///   - traitCollection: The optional UITraitCollection supported by the UIColor.
    /// - Returns: The named color, if found.
    public static func color(named name: String, in bundle: Bundle? = nil, bundleName: String? = nil, compatibleWith traitCollection: UITraitCollection? = nil) -> UIColor? {
        if let imageBundle = bundle {
            return UIColor(named: name, in: imageBundle, compatibleWith: traitCollection)
        } else if let bundleName = bundleName {
            return UIColor(named: name, in: BundleHelper.bundle(named: bundleName), compatibleWith: traitCollection)
        } else {
            return nil
        }
    }

    /// Utility function to return the named UIImage from the specified bundle supporting the specified UITraitCollection.
    ///
    /// - parameter named: The name of the UIImage without the filename extension
    /// - parameter bundle: The optional bundle that contains the UIImage. The default is the Bundle returned by resourceBundle()
    /// - parameter bundleName: Name of the bundle as substitutional parameter of Bundle.
    /// - parameter traitCollection: The optional UITraitCollection supported by the UIImage
    /// - returns: The named UIIMage within the bundle or nil if it is not found
    public static func image(named name: String, in bundle: Bundle? = nil, bundleName: String? = nil, compatibleWith traitCollection: UITraitCollection? = nil) -> UIImage? {
        if let imageBundle = bundle {
            return UIImage(named: name, in: imageBundle, compatibleWith: traitCollection)
        } else if let bundleName = bundleName {
            return UIImage(named: name, in: BundleHelper.bundle(named: bundleName), compatibleWith: traitCollection)
        } else {
            return nil
        }
    }

    public struct WrappedBundleImage: _ExpressibleByImageLiteral {
        let resourceName: String

        public init(imageLiteralResourceName name: String) {
            resourceName = name
        }
    }

    public static func image(wrappedImage: WrappedBundleImage, in bundle: Bundle? = nil, bundleName: String? = nil, compatibleWith traitCollection: UITraitCollection? = nil) -> UIImage? {
        return BundleHelper.image(named: wrappedImage.resourceName, in: bundle, bundleName: bundleName, compatibleWith: traitCollection)
    }

    /// Utility function to return the named UINib from the specified bundle.
    ///
    /// - parameter named: The name of the UINib without the filename extension
    /// - parameter bundle: The optional bundle that contains the UINib. The default is the Bundle returned by resourceBundle()
    /// - parameter bundleName: Name of the bundle as substitutional parameter of Bundle.
    /// - returns: The named UINib within the bundle or nil if it is not found
    public static func nib(named name: String, in bundle: Bundle? = nil, bundleName: String? = nil) -> UINib {
        if let nibBundle = bundle {
            return UINib(nibName: name, bundle: nibBundle)
        } else if let bundleName = bundleName {
            return UINib(nibName: name, bundle: BundleHelper.bundle(named: bundleName))
        } else {
            return UINib()
        }
    }

    /// Utility function to return the named UIStoryboard from the specified bundle.
    ///
    /// - parameter named: The name of the UIStoryboard without the filename extension
    /// - parameter bundle: The optional bundle that contains the UIStoryboard. The default is the Bundle returned by resourceBundle()
    /// - returns: The named UIStoryboard within the bundle or nil if it is not found
    public static func storyboard(named name: String, in bundle: Bundle? = nil, bundleName: String? = nil) -> UIStoryboard {
        if let storyboardBundle = bundle {
            return UIStoryboard(name: name, bundle: storyboardBundle)
        } else if let bundleName = bundleName {
            return UIStoryboard(name: name, bundle: BundleHelper.bundle(named: bundleName))
        } else {
            return UIStoryboard()
        }
    }

    /// Utility function to find the value for the key in a configuration file.
    ///
    /// - parameter key: The key in the AppConfig configuration file
    /// - parameter fileName: The configuration file name.
    /// - parameter fileType: The configuration file type e.g. "plist".

    /// - returns: The value for this key.
    static func getConfigurableValueForKey(key: String, fileName: String, fileType: String) -> Any? {
        return BundleHelper.getGlobalValueForKey(key: key, bundle: Bundle.main, fileName: fileName, fileType: fileType)
    }

    /// Utility function to find the value for the key in a configuration file.
    ///
    /// - parameter key: The key in the AppConfig configuration file
    /// - parameter bundle: The bundle that contains the file.
    /// - parameter fileName: The configuration file name.
    /// - parameter fileType: The configuration file type e.g. "plist".

    /// - returns: The value for this key.
    static func getGlobalValueForKey(key: String, bundle: Bundle, fileName: String, fileType: String) -> Any? {
        var propertyListFormat = PropertyListSerialization.PropertyListFormat.xml
        if let plistPath = bundle.path(forResource: fileName, ofType: fileType),
            let plistXML = FileManager.default.contents(atPath: plistPath) {
            do { // convert the data to a dictionary and handle errors
                if let plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as? [String: Any] {
                    if let val = getValueFromDict(key: key, dict: plistData) {
                        return val
                    }
                }
            } catch {
                print("Error parsing plist: \(error), format: \(propertyListFormat)")
            }
        }
        return nil
    }

    /// recursive function to find the val for the key.
    static func getValueFromDict(key: String, dict: [String: Any]) -> Any? {
        if let objStr = dict[key] {
            return objStr
        } else {
            for strDictKey in dict.keys {
                if let subDict = dict[strDictKey] as? [String: Any] {
                    if let val = getValueFromDict(key: key, dict: subDict) {
                        return val
                    }
                }
            }
        }
        return nil
    }
}
