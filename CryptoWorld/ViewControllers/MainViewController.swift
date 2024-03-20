//
//  ViewController.swift
//  CryptoWorld
//
//  Created by Иван Семикин on 17/03/2024.
//

import UIKit

final class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoins()
    }

    private func fetchCoins() {
        URLSession.shared.dataTask(with: Link.coins.url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                print(coins.map { "\($0)" }.joined(separator: "\n\n"))
            } catch {
                print(error)
            }
            
        }.resume()
    }
}

