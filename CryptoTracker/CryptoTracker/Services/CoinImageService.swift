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
    
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getImage()
    }
    
    private func getImage() {
        if let image = fileManager.getImageFromFileManager(imageName: imageName, folderName: folderName) {
            self.image = image
        } else {
            downloadImage()
        }
    }
    
    private func downloadImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.downloadData(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard 
                    let self = self,
                    let downloadedImage = returnedImage
                else { return }
                self.image = returnedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImageToFileManager(image: downloadedImage, folderName: self.folderName, imageName: self.imageName)
            })
    }
}
