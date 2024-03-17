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
    let current_price: Double
    let high_24h: Double
    let low_24h: Double
    let price_change_percentage_24h: Double
    let last_updated: String
}
