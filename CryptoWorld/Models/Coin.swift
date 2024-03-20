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
    let high24h: Double
    let low24h: Double
    let priceChangePercentage24h: Double
    let lastUpdated: String
}
