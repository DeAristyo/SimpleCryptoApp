//
//  NumberFormatter.swift
//  SimpleCryptoApp
//
//  Created by Dimas Aristyo Rahadian on 16/06/24.
//

import Foundation

extension NumberFormatter {
    static let abbreviated: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()
    
    //MARK: - Format number with $ Currency
    static func abbreviatedCurrencyString(from number: NSNumber) -> String {
        let doubleValue = number.doubleValue
        return abbreviatedCurrencyString(from: doubleValue)
    }
    
    static func abbreviatedCurrencyString(from number: Double) -> String {
        let trillion = number / 1_000_000_000_000
        if trillion >= 1.0 {
            return "$ \(self.abbreviated.string(from: NSNumber(value: trillion))!)T"
        }
        
        let billion = number / 1_000_000_000
        if billion >= 1.0 {
            return "$ \(self.abbreviated.string(from: NSNumber(value: billion))!)B"
        }
        
        let million = number / 1_000_000
        if million >= 1.0 {
            return "$ \(self.abbreviated.string(from: NSNumber(value: million))!)M"
        }
        
        let thousand = number / 1_000
        if thousand >= 1.0 {
            return "$ \(self.abbreviated.string(from: NSNumber(value: thousand))!)K"
        }
        
        return "$ \(self.abbreviated.string(from: NSNumber(value: number))!)"
    }
    
    
    //MARK: - Format Number only
    static func abbreviatedString(from number: NSNumber) -> String {
        let doubleValue = number.doubleValue
        return abbreviatedCurrencyString(from: doubleValue)
    }
    
    static func abbreviatedString(from number: Double) -> String {
        let trillion = number / 1_000_000_000_000
        if trillion >= 1.0 {
            return "\(self.abbreviated.string(from: NSNumber(value: trillion))!)T"
        }
        
        let billion = number / 1_000_000_000
        if billion >= 1.0 {
            return "\(self.abbreviated.string(from: NSNumber(value: billion))!)B"
        }
        
        let million = number / 1_000_000
        if million >= 1.0 {
            return "\(self.abbreviated.string(from: NSNumber(value: million))!)M"
        }
        
        let thousand = number / 1_000
        if thousand >= 1.0 {
            return "\(self.abbreviated.string(from: NSNumber(value: thousand))!)K"
        }
        
        return "\(self.abbreviated.string(from: NSNumber(value: number))!)"
    }
}
