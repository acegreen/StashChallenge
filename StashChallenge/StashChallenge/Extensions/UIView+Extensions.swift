//
//  UIView+Extensions.swift
//  StashChallenge
//
//  Created by Ace Green on 6/12/21.
//

import Foundation
import UIKit

// MARK: - Round Corners

public extension UIView {

    /// Round selected corners on a UIView
    /// Use it like this: myView.roundCorners([.topLeft, .bottomLeft], radius: 10)
    ///
    /// - Parameters:
    ///   - corners: array of corners
    ///   - radius: in pixels
    func roundedCorners(radius: CGFloat = 5,
                        color: UIColor? = nil,
                        width: CGFloat = 2.0,
                        corners: UIRectCorner = .allCorners) {
        layer.cornerRadius = radius
        layer.masksToBounds = true

        if let color = color {
            layer.borderColor = color.cgColor
            layer.borderWidth = width
        }
        layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
}

// MARK: - IBInspectable Corner radius, borderWidth, borderColor

@IBDesignable
public extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

@IBDesignable
public extension UIView {

    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let uiColor = newValue else { return }
            layer.shadowColor = uiColor.cgColor
        }
    }

    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
}
