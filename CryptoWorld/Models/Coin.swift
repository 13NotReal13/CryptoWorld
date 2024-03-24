//
//  Coin.swift
//  CryptoWorld
//
//  Created by Иван Семикин on 17/03/2024.
//

struct Coin {
    let name: String
    let symbol: String
    let image: String
    let currentPrice: Double
    let totalVolume: Double
    let high24H: Double
    let low24H: Double
    let priceChangePercentage24H: Double
    let lastUpdated: String
    
    init(coinDetails: [String: Any]) {
        name = coinDetails["name"] as? String ?? ""
        symbol = coinDetails["symbol"] as? String ?? ""
        image = coinDetails["image"] as? String ?? ""
        currentPrice = coinDetails["current_price"] as? Double ?? 0
        totalVolume = coinDetails["total_volume"] as? Double ?? 0
        high24H = coinDetails["high_24h"] as? Double ?? 0
        low24H = coinDetails["low_24h"] as? Double ?? 0
        priceChangePercentage24H = coinDetails["price_change_percentage_24h"] as? Double ?? 0
        lastUpdated = coinDetails["last_updated"] as? String ?? ""
    }
    
    static func getCoins(from value: Any) -> [Coin] {
        guard let coins = value as? [[String: Any]] else { return [] }
        return coins.map { Coin(coinDetails: $0) }
    }
}
