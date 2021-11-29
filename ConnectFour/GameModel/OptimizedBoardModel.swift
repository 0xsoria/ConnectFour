//
//  OptimizedBoardModel.swift
//  ConnectFour
//
//  Created by Gabriel Soria Souza on 28/09/21.
//

import Foundation

class OptimizedBoardModel: BoardGameModel {
    
    /**
        This function evaluate if there is a winner on the currect game. It uses the insertion of the user as a reference to start looking for connections. For example, if the user input a coin on (3, 3), this function checks the horizontal, vertical and diagonal possibilities only based on this index path.
     */
    
    override func isThereAWinner(from turn: BoardGameViewController.GameState,
                                 with data: [[Coin]],
                                 insertedAt: IndexPath) -> (Bool, [IndexPath]) {
        
        //horizontally increasing
        var indexes = [IndexPath]()
        
        for column in 0..<numberOfCollums {
            let item = data[insertedAt.section][column]
            if item.color == turn.colorFromState() {
                indexes.append(IndexPath(item: column, section: insertedAt.section))
            } else {
                indexes.removeAll()
            }
            if indexes.count == self.magicSequence {
                return (true, indexes)
            }
            if self.numberOfCollums - 1 - column + indexes.count < self.magicSequence {
                indexes.removeAll()
                break
            }
        }
        
        for line in 0..<numberOfLines {
            let item = data[line][insertedAt.item]
            if item.color == turn.colorFromState() {
                indexes.append(IndexPath(item: insertedAt.item, section: line))
            } else {
                indexes.removeAll()
            }
            if indexes.count == self.magicSequence {
                return (true, indexes)
            }
            if self.numberOfCollums - 1 - line + indexes.count < self.magicSequence {
                indexes.removeAll()
                break
            }
        }
        
        var diagonalIndexes = [IndexPath]()

        for item in 0..<max(self.numberOfCollums, self.numberOfLines) {
            if item + insertedAt.section <= self.numberOfLines - 1 {
                if item + insertedAt.item <= self.numberOfCollums - 1 {
                    diagonalIndexes.append(IndexPath(item: insertedAt.item + item,
                                                     section: insertedAt.section + item))
                }
            }
        }
        
        for item in 1..<max(self.numberOfCollums, self.numberOfLines) {
            if insertedAt.section - item <= self.numberOfLines - 1 &&  insertedAt.section - item >= 0 {
                if insertedAt.item - item <= self.numberOfCollums - 1 && insertedAt.item - item >= 0 {
                    diagonalIndexes.append(IndexPath(item: insertedAt.item - item,
                                                     section: insertedAt.section - item))
                }
            }
        }
        
        diagonalIndexes.sort(by: <)
        
        var winningIndexes = [IndexPath]()
        for (index, item) in diagonalIndexes.enumerated() {
            if data[item.section][item.item].color == turn.colorFromState() {
                winningIndexes.append(diagonalIndexes[index])
            } else {
                winningIndexes.removeAll()
            }
            if winningIndexes.count == self.magicSequence {
                return (true, winningIndexes)
            }
        }

        diagonalIndexes.removeAll()
        for item in 0..<max(self.numberOfCollums, self.numberOfLines) {
            if item + insertedAt.section <= self.numberOfLines - 1 {
                if insertedAt.item - item <= self.numberOfCollums && insertedAt.item - item >= 0 {
                    diagonalIndexes.append(IndexPath(item: insertedAt.item - item,
                                                     section: insertedAt.section + item))
                }
            }
        }
        ///range starts at 1 in order to avoid the repetition from last iteration
        for item in 1..<max(self.numberOfCollums, self.numberOfLines) {
            if insertedAt.section - item <= self.numberOfLines - 1 && insertedAt.section - item >= 0 {
                if item + insertedAt.item <= self.numberOfCollums - 1 {
                    diagonalIndexes.append(IndexPath(item: insertedAt.item + item,
                                                     section: insertedAt.section - item))
                }
            }
        }
        
        diagonalIndexes.sort(by: <)
        
        var winning = [IndexPath]()
        for (index, item) in diagonalIndexes.enumerated() {
            if data[item.section][item.item].color == turn.colorFromState() {
                winning.append(diagonalIndexes[index])
            } else {
                winning.removeAll()
            }
            if winning.count == self.magicSequence {
                return (true, winning)
            }
        }
        return (false, [])
    }
}
