//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by Микита Кузьмінов on 01.01.2024.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(searchText.isEmpty ? Color.secondaryText : Color.accent)
            
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundStyle(Color.accent)
                .keyboardType(.alphabet)
                .autocorrectionDisabled(true)
                .focused($isFocused)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    , alignment: .trailing
                )
                .onTapGesture {
                    searchText = ""
                    isFocused = false
                }
        }
        .font(.headline)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.background)
                .shadow(color: Color.accent.opacity(0.2),
                        radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
        }
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
