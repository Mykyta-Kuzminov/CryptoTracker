//
//  Double.swift
//  CryptoTracker
//
//  Created by Микита Кузьмінов on 28.12.2023.
//

import Foundation

extension Double {
    
    /// Converts a Double into a Currency with 2 decimals places
    /// ```
    /// Convert 1234.56 -> $1,234.56
    /// Convert 12.3456 -> $12.34
    /// Convert 0.123456 -> $0.12
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// Converts a Double into a Currency as a String with 2 decimals places
    /// ```
    /// Convert 1234.56 -> "$1,234.56"
    /// Convert 12.3456 -> "$12.34"
    /// Convert 0.123456 -> "$0.12"
    /// ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    /// Converts a Double into a Currency with 2-6 decimals places
    /// ```
    /// Convert 1234.56 -> $1,234.56
    /// Convert 12.3456 -> $12.3456
    /// Convert 0.123456 -> $0.123456
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Converts a Double into a Currency as a String with 2-6 decimals places
    /// ```
    /// Convert 1234.56 -> "$1,234.56"
    /// Convert 12.3456 -> "$12.3456"
    /// Convert 0.123456 -> "$0.123456"
    /// ```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Converts a Double into a string representation
    /// ```
    /// Conver 1.2345 -> "1.23"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Converts a Double into a string representation with percent symbol
    /// ```
    /// Conver 1.2345 -> "1.23%"
    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}
