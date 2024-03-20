//
//  ViewController.swift
//  CryptoWorld
//
//  Created by Иван Семикин on 17/03/2024.
//

import UIKit

final class MainViewController: UICollectionViewController {
    
    private let networkManager = NetworkManager.shared
    private var coins: [Coin] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .black
        fetchCoins()
    }
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        coins.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "coinInfo", for: indexPath)
        guard let cell = cell as? CoinCell else { return UICollectionViewCell() }
        let coin = coins[indexPath.item]
        cell.configure(with: coin)

        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: (view.window?.windowScene?.screen.bounds.width ?? 0) - 32,
            height: 70
        )
    }
}

// MARK: - Networking
extension MainViewController {
    private func fetchCoins() {
        networkManager.fetchCoins(from: Link.coins.url) { [unowned self] result in
            switch result {
            case .success(let coins):
                self.coins = coins
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
