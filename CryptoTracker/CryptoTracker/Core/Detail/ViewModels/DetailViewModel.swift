//
//  DetailViewModel.swift
//  CryptoTracker
//
//  Created by Микита Кузьмінов on 08.01.2024.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var details: CoinDetailModel? = nil
    
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        addSubcribers()
    }
    
    func addSubcribers() {
        coinDetailDataService.$details
            .sink { (returnedDetails) in
                // Code here...
            }
            .store(in: &cancellables)
    }
    
}
