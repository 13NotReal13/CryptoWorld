//
//  ViewController.swift
//  CryptoWorld
//
//  Created by Иван Семикин on 17/03/2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoins()
    }

    private func fetchCoins() {
        networkManager.fetchCoins(from: Link.coins.url) { result in
            switch result {
            case .success(let coins):
                print(coins)
            case .failure(let error):
                print(error)
            }
        }
    }
}

