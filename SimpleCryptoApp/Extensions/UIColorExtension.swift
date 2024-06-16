//
//  UIColorExtension.swift
//  SimpleCryptoApp
//
//  Created by Dimas Aristyo Rahadian on 16/06/24.
//

import UIKit

extension UIColor {
    static var appBackgroundColor: UIColor {
        return UIColor(named: "backgroundColor") ?? UIColor.white
    }

    static var appTextColor: UIColor {
        return UIColor(named: "textColor") ?? UIColor.black
    }
    
    static var primary: UIColor {
        return UIColor(named: "onPrimaryApp") ?? UIColor.yellow
    }
    
    static var secondary: UIColor {
        return UIColor(named: "onSecondaryApp") ?? UIColor.blue
    }
    
    static var primaryLow: UIColor {
        return UIColor(named: "onPrimaryLow") ?? UIColor.gray
    }
    
    static var secondaryLow: UIColor {
        return UIColor(named: "onPrimaryWhite") ?? UIColor.white
    }
}
