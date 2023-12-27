//
//  CircleButtonView.swift
//  CryptoTracker
//
//  Created by Микита Кузьмінов on 27.12.2023.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .foregroundStyle(Color.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .fill(Color.background)
            )
            .shadow(
                color: Color.accent.opacity(0.25),
                radius: 10, x: 0.0, y: 0.0)
            .padding()
    }
}

#Preview {
    CircleButtonView(iconName: "info")
}
