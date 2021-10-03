//
//  CoinCollectionViewItemswift.swift
//  ConnectFour
//
//  Created by Gabriel Soria Souza on 25/09/21.
//

import Cocoa

final class CoinCollectionViewItem: NSCollectionViewItem {
    
    private var coin: Coin = Coin(color: .empty)
    private lazy var coinView = CoinView(color: self.coin.color.nscolor())
    
    override func loadView() {
        self.view = self.coinView
        self.view.wantsLayer = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setCoin(_ coin: Coin) {
        self.coin = coin
        self.coinView.updateColor(color: coin.color.nscolor())
    }
}
