//
//  CoinDetailDataService.swift
//  CryptoTracker
//
//  Created by Микита Кузьмінов on 08.01.2024.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var details: CoinDetailModel? = nil
    
    var coinDetailSubscription: AnyCancellable?
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        downloadData()
    }
    
    func downloadData() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
        else { return }
        
        coinDetailSubscription = NetworkingManager.downloadData(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedDetails) in
                guard let self = self else { return }
                self.details = returnedDetails
                self.coinDetailSubscription?.cancel()
            })
    }
}
