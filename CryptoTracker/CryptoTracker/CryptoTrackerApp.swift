//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Микита Кузьмінов on 27.12.2023.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden)
                    .environmentObject(vm)
            }
        }
    }
}
