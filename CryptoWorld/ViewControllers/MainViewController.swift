//
//  MainViewController.swift
//  CryptoWorld
//
//  Created by Иван Семикин on 17/03/2024.
//

import UIKit

final class MainViewController: UICollectionViewController {
    
    // MARK: - Private Properties
    private let networkManager = NetworkManager.shared
    private var coins: [Coin] = []
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var filteredCoins = [Coin]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {
            return false
        }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: - Life Cycle View
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .black
        setupSearchController()
        fetchCoins()
    }
    
    // MARK: - Private Methods
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .white
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if isFiltering {
            filteredCoins.count
        } else {
            coins.count
        }
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "coinInfo", for: indexPath)
        guard let cell = cell as? CoinCell else { return UICollectionViewCell() }
        
        let coin = isFiltering ? filteredCoins[indexPath.row] : coins[indexPath.row]
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

// MARK: - UISearchResultUpdatingDelegate
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredCoins = coins.filter({ (coin: Coin) -> Bool in
            return coin.name.lowercased().contains(searchText.lowercased())
        })
        collectionView.reloadData()
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
