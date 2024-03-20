//
//  NetworkManager.swift
//  CryptoWorld
//
//  Created by Иван Семикин on 20/03/2024.
//

import Foundation

enum Link {
    case coins
    
    var url: URL {
        URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=10")!
    }
}

enum NetworkError: Error {
    case noData
    case decodingError
}

struct NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCoins(from url: URL, completion: @escaping(Result<[Coin], NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let coins = try decoder.decode([Coin].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(coins))
                }
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
}
