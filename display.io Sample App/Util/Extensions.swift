//
//  Extensions.swift
//  display.io Sample App
//
//  Created by akrat on 7/23/18.
//  Copyright © 2018 akrat. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func border(colorHex: String, width: CGFloat) {
        self.layer.borderColor = UIColor(hex: colorHex).cgColor
        self.layer.borderWidth = width
    }
    
    func corner(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func matchParent() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: self,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: self,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: self,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: self,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 0).isActive = true
    }
}

extension UITableViewCell {
    static func identifier() -> String {
        return String(describing: self)
    }
}

extension UIViewController {
    static func identifier() -> String {
        return String(describing: self)
    }
    
    func showToast(message: String, duration: Int, isError: Bool = false) {
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = UIColor.white
        //let toast = UIView(frame: CGRect(x: , y: , width: , height: ))
    }
}

extension UIStoryboard {
    convenience init(_ name: Name) {
        self.init(name: name.rawValue, bundle: nil)
    }
    
    enum Name: String {
        case main = "Main"
        case show = "ShowPlacement"
        case add = "AddPlacement"
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: alpha
        )
    }
}

