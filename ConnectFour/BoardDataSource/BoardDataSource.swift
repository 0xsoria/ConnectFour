//
//  BoardDataSource.swift
//  ConnectFour
//
//  Created by Gabriel Soria Souza on 25/09/21.
//

import AppKit

protocol BoardDataSourceDelegate: AnyObject {
    func didSelect(at indexPath: IndexPath, data: [[Coin]])
    func didUpdate(at indexPath: IndexPath, from data: [[Coin]])
    func didMakeNewGame()
}

final class BoardDataSource: NSObject, NSCollectionViewDataSource, NSCollectionViewDelegate {
    
    private(set) var dataSet: [[Coin]] = []
    weak var delegate: BoardDataSourceDelegate?
    
    func startNewData(numberOfLines: Int, numberOfCollums: Int) {
        self.dataSet = self.makeCollection(with: numberOfLines, and: numberOfCollums)
        self.delegate?.didMakeNewGame()
    }

    func updateData(at indexPath: IndexPath, coinColor: Coin.CoinColor) {
        self.dataSet[indexPath.section][indexPath.item].color = coinColor
        self.delegate?.didUpdate(at: indexPath, from: self.dataSet)
    }

    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        self.dataSet.count
    }

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSet[section].count
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        if let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: MainView.TitlesAndNames.itemID.rawValue), for: indexPath) as? CoinCollectionViewItem {
            item.setCoin(self.dataSet[indexPath.section][indexPath.item])
            return item
        }
        return NSCollectionViewItem()
    }

    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        collectionView.deselectItems(at: indexPaths)
        if let first = indexPaths.first {
            self.delegate?.didSelect(at: first, data: self.dataSet)
        }
    }

    private func makeCollection(with numberOfLines: Int, and numberOfCollums: Int) -> [[Coin]] {
        let column = Array(repeating: Coin(color: .empty), count: numberOfCollums)
        let line = Array(repeating: column, count: numberOfLines)
        return line
    }
}
