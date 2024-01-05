//
//  HapticManager.swift
//  CryptoTracker
//
//  Created by Микита Кузьмінов on 05.01.2024.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notigication(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
