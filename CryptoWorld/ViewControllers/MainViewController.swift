//
//  ViewController.swift
//  CryptoWorld
//
//  Created by Иван Семикин on 17/03/2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let link = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=10")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

