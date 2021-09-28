//
//  MainModel.swift
//  ConnectFour
//
//  Created by Gabriel Soria Souza on 25/09/21.
//

import Foundation

protocol BoardGameDelegate: AnyObject {
    func shouldMakeInitialSetup(numberOfLines: Int, numberOfCollums: Int)
    func shouldStartNewGame(newState: BoardGameViewController.GameState,
                         numberOfLines: Int,
                         numberOfCollums: Int)
    func shouldAddItem(at indexPath: IndexPath,
                    to color: Coin.CoinColor)
    func didStartIntelligentSelection()
    func didFinishIntelligentSelection()
    func shouldUpdateTurn(_ turn: BoardGameViewController.GameState)
    func shouldFinishTheGame(winner: Coin.CoinColor,
                             indexes: [IndexPath],
                             state: BoardGameViewController.GameState)
    func gameOver()
}

protocol BoardModel {
    var numberOfLines: Int { get }
    var numberOfCollums: Int { get }
    var magicSequence: Int { get }
    var intellgentSelection: Bool { get }
}

class BoardGameModel {

    ///Set to true if wants to play agains the AI (yellow coin).
    var intelligentSelection: Bool
    var numberOfLines: Int
    var numberOfCollums: Int
    var magicSequence: Int
    weak var delegate: BoardGameDelegate?
    
    init(model: BoardModel) {
        self.intelligentSelection = model.intellgentSelection
        self.numberOfLines = model.numberOfLines
        self.numberOfCollums = model.numberOfCollums
        self.magicSequence = model.magicSequence
    }

    /**
    Ask the model where to add a coin based on the selected item of the index path, the function calculates the correct line (section) to place the coin and informs the delegate where to place it. If there is no free line, it returns nothing.
     - Parameter indexPath: IndexPath selected (line and column).
     - Parameter turn: Who's the current turn.
     - Parameter dataSet: Dataset to have the coin inserted.
     */
    func addItem(at indexPath: IndexPath,
                 turn: BoardGameViewController.GameState,
                 dataSet: [[Coin]]) {
        guard turn != .notStarted else {
            return
        }
        
        guard turn != .over else {
            return
        }
        
        //if it is not intelligentSelection, it means that two players can play.
        if self.intelligentSelection {
            if turn == .yellowTurn {
                return
            }
        }

        //analize positions and data set and informs the delegate where to place the new item.
        if let newIndex = self.getCorrectLineFromColumn(indexPath: indexPath,
                                                        data: dataSet) {
            let coinColor = self.colorFrom(currentTurn: turn)
            self.delegate?.shouldAddItem(at: newIndex, to: coinColor)
        }
    }
    
    /**
     Analyze if there is any winner in the current data set. If there isn't any winner, the delegate is informed to start a new turn.
     - Parameter turn: Who's the current turn.
     - Parameter data: Current data set.
     - Important: If playing agains the AI, when the AI takes over, the delegate is informed the AI started thinking and when it's over.
     */
    func analyzeGameResultAndTakeTurn(from turn: BoardGameViewController.GameState,
                                      with data: [[Coin]], insertedAt: IndexPath) {
        //analyze result and positions
        let result = self.isThereAWinner(from: turn, with: data, insertedAt: insertedAt)
        if result.0 {
            self.delegate?.shouldFinishTheGame(winner: turn.colorFromState(),
                                               indexes: result.1,
                                               state: .over)
            return
        }
        
        //check if there is a tie.
        if self.isATie(with: data) {
            self.delegate?.gameOver()
            return
        }
        
        //if there isn't any winner
        let newTurn = self.newTurn(currentTurn: turn)
        self.delegate?.shouldUpdateTurn(newTurn)
        
        //if playing agains AI and it is the AI turn, make the ramdom selection after X seconds.
        if newTurn == .yellowTurn && self.intelligentSelection {
            self.delegate?.didStartIntelligentSelection()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.delegate?.didStartIntelligentSelection()
                //make random selection
                self.getFreeIndex(data: data, from: newTurn)
                self.delegate?.didFinishIntelligentSelection()
            }
        }
    }
    
    private func isATie(with data: [[Coin]]) -> Bool {
        for coin in data.first ?? [] {
            if coin.color == .empty {
                return false
            }
        }
        return true
    }
    
    func isThereAWinner(from turn: BoardGameViewController.GameState,
                        with data: [[Coin]],
                        insertedAt: IndexPath) -> (Bool, [IndexPath]) {
        for (indexOfLine, line) in data.enumerated() {
            var indexes: [IndexPath] = []
            for (indexOfColumn, item) in line.enumerated() {
                if item.color == self.colorFrom(currentTurn: turn) {
                    indexes.append(IndexPath(item: indexOfColumn, section: indexOfLine))
                } else {
                    indexes.removeAll()
                }
                if indexes.count == self.magicSequence {
                    return (true, indexes)
                }
            }
            indexes.removeAll()
        }
        
        for column in 0..<self.numberOfCollums {
            var indexes: [IndexPath] = []
            for line in 0..<self.numberOfLines {
                let item  = data[line][column]
                if item.color == self.colorFrom(currentTurn: turn) {
                    indexes.append(IndexPath(item: column, section: line))
                } else {
                    indexes.removeAll()
                }
                if indexes.count == self.magicSequence {
                    return (true, indexes)
                }
            }
            indexes.removeAll()
        }
        
        //diagonal -> left to right
        for line in 0..<self.numberOfLines {
            var indexes: [IndexPath] = []
            for column in 0..<self.numberOfCollums {
                guard line + column <= self.numberOfLines - 1 else {
                    continue
                }
                if data[line + column][column].color == self.colorFrom(currentTurn: turn) {
                    indexes.append(IndexPath(item: column, section: line + column))
                } else {
                    indexes.removeAll()
                }
                if indexes.count == self.magicSequence {
                    return (true, indexes)
                }
            }
            indexes.removeAll()
        }
        
        for column in 0..<self.numberOfCollums {
            var indexes: [IndexPath] = []
            for line in 0..<self.numberOfLines {
                guard line + column <= self.numberOfCollums - 1 else {
                    continue
                }
                if data[line][line + column].color == self.colorFrom(currentTurn: turn) {
                    indexes.append(IndexPath(item: line + column, section: line))
                } else {
                    indexes.removeAll()
                }
                if indexes.count == self.magicSequence {
                    return (true, indexes)
                }
            }
            indexes.removeAll()
        }
        //diagonal -> left to right - end
        
        
        //diagonal - right to left
        for line in 0..<self.numberOfLines {
            var indexes: [IndexPath] = []
            for column in 0..<self.numberOfCollums {
                guard line + column <= self.numberOfLines - 1 else {
                    continue
                }
                if data[line + column][self.numberOfCollums - 1 - column].color == self.colorFrom(currentTurn: turn) {
                    indexes.append(IndexPath(item: self.numberOfCollums - 1 - column, section: line + column))
                } else {
                    indexes.removeAll()
                }
                if indexes.count == self.magicSequence {
                    return (true, indexes)
                }
            }
            indexes.removeAll()
        }
        
        for column in 0..<self.numberOfCollums {
            var indexes: [IndexPath] = []
            for line in 0..<self.numberOfLines {
                guard line + column <= self.numberOfCollums - 1 else {
                    continue
                }
                if data[line][self.numberOfCollums - 1 - (line + column)].color == self.colorFrom(currentTurn: turn) {
                    indexes.append(IndexPath(item: self.numberOfCollums - 1 - (line + column), section: line))
                } else {
                    indexes.removeAll()
                }
                if indexes.count == self.magicSequence {
                    return (true, indexes)
                }
            }
            indexes.removeAll()
        }
        //diagonal -> right to left - end
        
        return (false, [])
    }
    
    private func getFreeIndex(data: [[Coin]], from turn: BoardGameViewController.GameState) {
        if let freeIndex = self.getRandomFreeIndex(data: data),
           let correctLine = self.getCorrectLineFromColumn(indexPath: freeIndex, data: data) {
               self.delegate?.shouldAddItem(at: correctLine,
                                      to: self.colorFrom(currentTurn: turn))
            self.delegate?.didFinishIntelligentSelection()
        } else {
            self.delegate?.gameOver()
        }
    }
    
    /**
     Based on the chosen column of the data set, returns the correct line to place the coin.
     
     - Returns: `IndexPath` of the chosen column and first free line. If it returns `nil`, it means there is no free line in the chosen column.
     */
    private func getCorrectLineFromColumn(indexPath: IndexPath,
                                          data: [[Coin]]) -> IndexPath? {
        for i in (0..<self.numberOfLines) {
            if data[self.numberOfLines - i - 1][indexPath.item].color == .empty {
                return IndexPath(item: indexPath.item,
                                 section: self.numberOfLines - i - 1)
            }
        }
        return nil
    }

    /**
        Get a free random index, if it returns nil, means there is no free index and the game is over.
     */
    private func getRandomFreeIndex(data: [[Coin]]) -> IndexPath? {
        for line in 0..<self.numberOfLines {
            var indexes: [IndexPath] = []
            for collumn in 0..<self.numberOfCollums {
                //checking in reversed order for efficiency
                if data[line][collumn].color == .empty {
                    indexes.append(IndexPath(item: collumn,
                                             section: line))
                }
            }
            if !indexes.isEmpty {
                return indexes.randomElement()
            } else {
                continue
            }
        }
        return nil
    }
    
    /**
     Informs the delegate what size of the board should be done.
     */
    func initialSetup() {
        self.delegate?.shouldMakeInitialSetup(numberOfLines: self.numberOfLines,
                                       numberOfCollums: self.numberOfCollums)
    }

    /**
     Informs the delegate who starts a game and the size of the board.
     */
    func newGame() {
        self.delegate?.shouldStartNewGame(newState: .redTurn,
                                       numberOfLines: self.numberOfLines,
                                       numberOfCollums: self.numberOfCollums)
    }
    
    private func colorFrom(currentTurn: BoardGameViewController.GameState) -> Coin.CoinColor {
        if currentTurn == .redTurn {
            return .red
        } else if currentTurn == .yellowTurn {
            return .yellow
        }
        return .empty
    }

    ///Based on the current turn, returns who's next turn. If game hasn't started, return `.notStarted` state.
    private func newTurn(currentTurn: BoardGameViewController.GameState) -> BoardGameViewController.GameState {
        if currentTurn == .redTurn {
            return .yellowTurn
        } else if currentTurn == .yellowTurn {
            return .redTurn
        }
        return .notStarted
    }
}
