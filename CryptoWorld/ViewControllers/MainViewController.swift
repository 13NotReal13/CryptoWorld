//
//  ViewController.swift
//  CryptoWorld
//
//  Created by Иван Семикин on 17/03/2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let link = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=10")!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoins()
    }

    private func fetchCoins() {
        URLSession.shared.dataTask(with: link) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                
                coins.forEach { coin in
                    print("\(coin)\n")
                }
            } catch {
                print(error)
            }
            
        }.resume()
    }
}

