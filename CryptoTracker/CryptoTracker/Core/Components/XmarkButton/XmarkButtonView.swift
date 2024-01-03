//
//  XmarkButtonView.swift
//  CryptoTracker
//
//  Created by Микита Кузьмінов on 03.01.2024.
//

import SwiftUI

struct XmarkButtonView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}

#Preview {
    XmarkButtonView()
}
