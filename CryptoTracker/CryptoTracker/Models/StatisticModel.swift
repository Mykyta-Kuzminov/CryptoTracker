//
//  StatisticModel.swift
//  CryptoTracker
//
//  Created by Микита Кузьмінов on 02.01.2024.
//

import Foundation

struct StatisticModel: Identifiable {
    var id: String = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
    
}
