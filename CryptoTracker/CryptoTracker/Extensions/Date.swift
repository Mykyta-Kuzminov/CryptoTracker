//
//  Date.swift
//  CryptoTracker
//
//  Created by Микита Кузьмінов on 09.01.2024.
//

import Foundation

extension Date {
    
    init(coinDateString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinDateString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }
    
    private var monthFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter
    }
    
    func asDayString() -> String {
        return dayFormatter.string(from: self)
    }
    
    func asMonthString() -> String {
        return monthFormatter.string(from: self)
    }
}
