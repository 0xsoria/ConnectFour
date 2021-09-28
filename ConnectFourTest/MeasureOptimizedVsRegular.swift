//
//  MeasureOptimizedVsRegular.swift
//  ConnectFourTest
//
//  Created by Gabriel Soria Souza on 28/09/21.
//

import XCTest
@testable import ConnectFour

class MeasureOptimizedVsRegular: XCTestCase {
    
    var controller: BoardController!

    func insertAndTakeTurn(at: IndexPath) {
        self.controller.sut?.addItem(at: at,
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
    }

    func testOptimized() {
        controller = BoardController()
        controller.model = ConnectFourModel()
        controller.sutDelegate = BoardDataSourceForTest()
        controller.sut = OptimizedBoardModel(model: self.controller.model!)
        controller.sut?.delegate = self.controller.sutDelegate
        controller.sutDelegate?.delegate = self.controller
        self.controller.sut?.initialSetup()
        self.controller.sut?.newGame()
        
        self.measure {
            self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        }
    }
    
    func testRegular() {
        controller = BoardController()
        controller.model = ConnectFourModel()
        controller.sutDelegate = BoardDataSourceForTest()
        controller.sut = BoardGameModel(model: self.controller.model!)
        controller.sut?.delegate = self.controller.sutDelegate
        controller.sutDelegate?.delegate = self.controller
        self.controller.sut?.initialSetup()
        self.controller.sut?.newGame()
        
        self.measure {
            self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        }
    }
    
    func testRegularIfThereIsWinner() {
        let model = BoardGameModel(model: ConnectFourModelTwoPlayers())
        var data = self.makeEmptyData()
        data[5][2].color = .red
        self.measure {
            _ = model.isThereAWinner(from: .redTurn, with: data, insertedAt: IndexPath(item: 2, section: 5))
        }
    }
    
    func testOptimizedIfThereIsWinner() {
        let model = OptimizedBoardModel(model: ConnectFourModelTwoPlayers())
        var data = self.makeEmptyData()
        data[5][2].color = .red
        self.measure {
            _ = model.isThereAWinner(from: .redTurn, with: data, insertedAt: IndexPath(item: 2, section: 5))
        }
    }
    
    func makeEmptyData() -> [[Coin]] {
        return [
            [Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty)],
            [Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty)],
            [Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty)],
            [Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty)],
            [Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty)],
            [Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty), Coin(color: .empty)]
        ]
    }
}
