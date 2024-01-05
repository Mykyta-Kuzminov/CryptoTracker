//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by Микита Кузьмінов on 29.12.2023.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    
    var coinSubscription: AnyCancellable?
    
    init() {
        downloadData()
    }
    
    func downloadData() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=en&precision=10")
        else { return }
        
        coinSubscription = NetworkingManager.downloadData(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedData) in
                guard let self = self else { return }
                self.allCoins = returnedData
                self.coinSubscription?.cancel()
            })
    }
    
}
