//
//  CoinCell.swift
//  CryptoWorld
//
//  Created by Иван Семикин on 20/03/2024.
//

import UIKit

final class CoinCell: UICollectionViewCell {
    
    @IBOutlet var nameCoin: UILabel!
    @IBOutlet var totalVolume: UILabel!
    @IBOutlet var currentPrice: UILabel!
    @IBOutlet var currentPriceWithCurrency: UILabel!
    @IBOutlet var priceChangePercentage24H: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with coin: Coin) {
        nameCoin.text = coin.name.uppercased()
        totalVolume.text = formatVolume(coin.totalVolume)
        currentPrice.text = String(coin.currentPrice)
        currentPriceWithCurrency.text = "\(coin.currentPrice) USD"
        
        let formattedPercent = coin.priceChangePercentage24H >= 0
            ? "+\(String(format: "%.2f", coin.priceChangePercentage24H))%"
            : "\(String(format: "%.2f", coin.priceChangePercentage24H))%"
        priceChangePercentage24H.text = formattedPercent
        
        if coin.priceChangePercentage24H >= 0 {
            priceChangePercentage24H.backgroundColor = .systemGreen
        } else {
            priceChangePercentage24H.backgroundColor = .systemRed
        }
        
        priceChangePercentage24H.layer.cornerRadius = 6
        priceChangePercentage24H.layer.masksToBounds = true
    }
    
    private func formatVolume(_ volume: Double) -> String {
        let abbreviated: String
        
        switch volume {
        case 0..<1_000_000:
            abbreviated = "\(volume)"
        case 1_000_000..<1_000_000_000:
            abbreviated = "\(String(format: "%.3f", volume / 1_000_000))M"
        default:
            abbreviated = "\(String(format: "%.3f", volume / 1_000_000_000))B"
        }
        
        return abbreviated
    }
}
