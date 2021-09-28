//
//  BoardController.swift
//  ConnectFourTest
//
//  Created by Gabriel Soria Souza on 28/09/21.
//

import Foundation

@testable import ConnectFour

class BoardController: BoardDataSourceDelegate {
    
    var sut: BoardGameModel?
    var sutDelegate: BoardDataSourceForTest?
    var model: BoardModel?
    
    func didSelect(at indexPath: IndexPath, data: [[Coin]]) {
        //
    }
    
    func didUpdate(at indexPath: IndexPath, from data: [[Coin]]) {
        self.sut?.analyzeGameResultAndTakeTurn(from: self.sutDelegate!.state,
                                               with: self.sutDelegate!.dataSet, insertedAt: indexPath)
    }
    
    func didMakeNewGame() {
        //
    }
}
