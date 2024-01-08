//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Микита Кузьмінов on 07.01.2024.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var vm: DetailViewModel
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        Text("Hello!")
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
}
