//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Микита Кузьмінов on 29.12.2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscriber()
    }
    
    func addSubscriber() {
        
        dataService.$allCoins
            .sink { [weak self] (returnedData) in
                self?.allCoins = returnedData
            }
            .store(in: &cancellables)
        
    }
    
}
