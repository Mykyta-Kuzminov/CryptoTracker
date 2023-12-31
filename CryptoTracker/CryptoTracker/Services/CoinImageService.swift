//
//  CoinImageService.swift
//  CryptoTracker
//
//  Created by Микита Кузьмінов on 31.12.2023.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    var imageSubscription: AnyCancellable?
    
    init(coin: CoinModel) {
        downloadImage(urlString: coin.image)
    }
    
    private func downloadImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        imageSubscription = NetworkingManager.downloadData(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self else { return }
                self.image = returnedImage
                self.imageSubscription?.cancel()
            })
    }
}
