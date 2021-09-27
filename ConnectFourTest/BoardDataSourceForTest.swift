//
//  BoardDataSourceForTest.swift
//  ConnectFourTest
//
//  Created by Gabriel Soria Souza on 27/09/21.
//

import Foundation
@testable import ConnectFour

struct ConnectFiveModelTwoPlayers: BoardModel {
    var numberOfLines: Int {
        6
    }

    var numberOfCollums: Int {
        7
    }

    var magicSequence: Int {
        5
    }

    var intellgentSelection: Bool {
        false
    }
}

struct ConnectFourModelTwoPlayers: BoardModel {
    var numberOfLines: Int {
        6
    }

    var numberOfCollums: Int {
        7
    }

    var magicSequence: Int {
        4
    }

    var intellgentSelection: Bool {
        false
    }
}

final class BoardDataSourceForTest: BoardGameDelegate {

    var state: BoardGameViewController.GameState = .notStarted
    var dataSet: [[Coin]] = []
    var winner:  Coin.CoinColor?
    var winnerIndexes: [IndexPath] = []
    
    func shouldMakeInitialSetup(numberOfLines: Int, numberOfCollums: Int) {
        self.dataSet = self.makeCollection(with: numberOfLines, and: numberOfCollums)
    }
    
    func shouldStartNewGame(newState: BoardGameViewController.GameState, numberOfLines: Int, numberOfCollums: Int) {
        self.state = newState
        self.dataSet = self.makeCollection(with: numberOfLines, and: numberOfCollums)
    }
    
    func shouldAddItem(at indexPath: IndexPath, to color: Coin.CoinColor) {
        self.dataSet[indexPath.section][indexPath.item].color = color
    }
    
    func didStartIntelligentSelection() {
        //
    }
    
    func didFinishIntelligentSelection() {
        //
    }
    
    func shouldUpdateTurn(_ turn: BoardGameViewController.GameState) {
        self.state = turn
    }
    
    func shouldFinishTheGame(winner: Coin.CoinColor, indexes: [IndexPath], state: BoardGameViewController.GameState) {
        self.state = state
        self.winner = winner
        self.winnerIndexes.removeAll()
        self.winnerIndexes = indexes
    }
    
    func gameOver() {
        self.state = .over
    }
    
    private func makeCollection(with numberOfLines: Int, and numberOfCollums: Int) -> [[Coin]] {
        let column = Array(repeating: Coin(color: .empty), count: numberOfCollums)
        let line = Array(repeating: column, count: numberOfLines)
        return line
    }
}

