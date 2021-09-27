//
//  CoinCollectionViewItemswift.swift
//  ConnectFour
//
//  Created by Gabriel Soria Souza on 25/09/21.
//

import Cocoa

final class CoinCollectionViewItem: NSCollectionViewItem {
    
    private var coin: Coin = Coin(color: .empty)
    private lazy var image: NSImageView = {
        let iv = NSImageView(image: self.getImage(from: self.coin.color) ?? NSImage())
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: 120, height: 120))
        self.view.wantsLayer = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
    }

    func setCoin(_ coin: Coin) {
        self.coin = coin
        self.image.image = self.getImage(from: coin.color)
    }
    
    private func setupLayout() {
        self.view.addSubview(image)
        self.image.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.image.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.image.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.image.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }

    private func getImage(from color: Coin.CoinColor) -> NSImage? {
        switch color {
        case .empty:
            return nil
        case .red:
            return NSImage(named: .redCoin)
        case .yellow:
            return NSImage(named: .yellowCoin)
        }
    }
}
