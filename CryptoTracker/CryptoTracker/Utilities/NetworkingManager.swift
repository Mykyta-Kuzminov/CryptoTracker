//
//  NetworkingManager.swift
//  CryptoTracker
//
//  Created by Микита Кузьмінов on 31.12.2023.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse
        case unknown
        
        var errorDescription: String {
            switch self {
            case .badURLResponse: return "Bad response from URL."
            case .unknown: return "Unknown error occured"
            }
        }
        
    }
    
    static func downloadData(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .receive(on: DispatchQueue.main)
            .tryMap(handleURLResponse)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else { throw NetworkingError.badURLResponse }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
                break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
