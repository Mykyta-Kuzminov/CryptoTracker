//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by Микита Кузьмінов on 02.01.2024.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    
    var marketDataSubscription: AnyCancellable?
    
    init() {
        downloadData()
    }
    
    private func downloadData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global")
        else { return }
        
        marketDataSubscription = NetworkingManager.downloadData(url: url)
            .decode(type: GlobalMarketData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedData) in
                guard let self = self else { return }
                self.marketData = returnedData.data
                self.marketDataSubscription?.cancel()
            })
    }
}
