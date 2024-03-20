//
//  Coin.swift
//  CryptoWorld
//
//  Created by Иван Семикин on 17/03/2024.
//

import Foundation

struct Coin: Decodable {
    let name: String
    let symbol: String
    let image: URL
    let currentPrice: Double
    let high24H: Double
    let low24H: Double
    let priceChangePercentage24H: Double
    let lastUpdated: String
}
