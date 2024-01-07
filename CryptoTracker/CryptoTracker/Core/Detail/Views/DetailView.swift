//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Микита Кузьмінов on 07.01.2024.
//

import SwiftUI

struct DetailView: View {
    
    let coin: CoinModel
    
    var body: some View {
        Text(coin.name)
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
}
