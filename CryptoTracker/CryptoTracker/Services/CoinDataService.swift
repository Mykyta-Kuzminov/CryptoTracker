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
    
    private func downloadData() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=en&precision=10")
        else { return }
        
        coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .receive(on: DispatchQueue.main)
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300
                else { throw URLError(.badServerResponse)}
                return output.data
            }
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                        break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] (returnedData) in
                guard let self = self else { return }
                self.allCoins = returnedData
                self.coinSubscription?.cancel()
            }
    }
    
}
