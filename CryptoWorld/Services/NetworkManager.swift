//
//  NetworkManager.swift
//  CryptoWorld
//
//  Created by Иван Семикин on 20/03/2024.
//

import Foundation
import Alamofire

enum Link {
    case coins
    
    var url: URL {
        URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=50")!
    }
}

struct NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCoinsWithParse(from url: URL, completion: @escaping(Result<[Coin], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let coins):
                    completion(.success(Coin.getCoins(from: coins)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
