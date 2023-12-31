//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by Микита Кузьмінов on 31.12.2023.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let coin: CoinModel
    private let imageService: CoinImageService
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageService = CoinImageService(coin: coin)
        self.addSubscriber()
        self.isLoading = true
    }
    
    private func addSubscriber() {
        
        imageService.$image
            .sink(receiveCompletion: { [weak self] (_) in
                self?.isLoading = false
            }, receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            })
            .store(in: &cancellables)
    }
}
