//
//  TestOptimizedBoard.swift
//  ConnectFourTest
//
//  Created by Gabriel Soria Souza on 27/09/21.
//

import XCTest
@testable import ConnectFour

class TestOptimizedBoard: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHorizontallyWithRedInTheFirstLine() {
        let optimizedModel = OptimizedBoardModel(model: ConnectFourModelTwoPlayers())
        var data = self.makeEmptyData()
        data[5][2].color = .red
        _ = optimizedModel.isThereAWinner(from: .redTurn,
                                                  with: data,
                                                  insertedAt: IndexPath(item: 2, section: 5))
        data[4][3].color = .yellow
        _ = optimizedModel.isThereAWinner(from: .yellowTurn,
                                                  with: data,
                                                  insertedAt: IndexPath(item: 3, section: 4))
        
        data[3][4].color = .yellow
        _ = optimizedModel.isThereAWinner(from: .yellowTurn,
                                                  with: data,
                                                  insertedAt: IndexPath(item: 4, section: 3))
    
        
        data[1][6].color = .yellow
        _ = optimizedModel.isThereAWinner(from: .yellowTurn,
                                                  with: data,
                                                  insertedAt: IndexPath(item: 6, section: 1))

        data[2][5].color = .yellow
        let winner = optimizedModel.isThereAWinner(from: .yellowTurn,
                                                  with: data,
                                                  insertedAt: IndexPath(item: 5, section: 2))
        
        XCTAssertTrue(winner.0)
        XCTAssertFalse(winner.1.isEmpty)
    }
    
    func testHorizontallyIncreasingLeftToRight() {
        let optimizedModel = OptimizedBoardModel(model: ConnectFourModelTwoPlayers())
        var data = self.makeEmptyData()
        data[5][2].color = .yellow
        _ = optimizedModel.isThereAWinner(from: .yellowTurn,
                                                  with: data,
                                                  insertedAt: IndexPath(item: 2, section: 5))
        data[4][3].color = .yellow
        _ = optimizedModel.isThereAWinner(from: .yellowTurn,
                                                  with: data,
                                                  insertedAt: IndexPath(item: 3, section: 4))
        
        data[3][4].color = .yellow
        let notWinner = optimizedModel.isThereAWinner(from: .yellowTurn,
                                                  with: data,
                                                  insertedAt: IndexPath(item: 4, section: 3))
        
        XCTAssertFalse(notWinner.0)
        XCTAssertTrue(notWinner.1.isEmpty)
        
        data[1][6].color = .red
        let notWinnerRed = optimizedModel.isThereAWinner(from: .redTurn,
                                                  with: data,
                                                  insertedAt: IndexPath(item: 5, section: 1))
        
        XCTAssertFalse(notWinnerRed.0)
        XCTAssertTrue(notWinnerRed.1.isEmpty)

        data[2][5].color = .yellow
        let winner = optimizedModel.isThereAWinner(from: .yellowTurn,
                                                  with: data,
                                                  insertedAt: IndexPath(item: 5, section: 2))
        
        XCTAssertTrue(winner.0)
        XCTAssertFalse(winner.1.isEmpty)
    }
    
    func testHorizontalIncreasingColumns() {
        let optimizedModel = OptimizedBoardModel(model: ConnectFourModelTwoPlayers())
        var data = self.makeEmptyData()
        data[5][0].color = .red
        let winner = optimizedModel.isThereAWinner(from: .redTurn,
                                      with: data,
                                      insertedAt: IndexPath(item: 0, section: 5))
        XCTAssertFalse(winner.0)
        XCTAssertTrue(winner.1.isEmpty)
        
        data[4][0].color = .yellow
        let winnerYellow = optimizedModel.isThereAWinner(from: .redTurn,
                                      with: data,
                                      insertedAt: IndexPath(item: 0, section: 4))
        XCTAssertFalse(winnerYellow.0)
        XCTAssertTrue(winnerYellow.1.isEmpty)
    }
    
    func testDiagonally() {
        let optimizedModel = OptimizedBoardModel(model: ConnectFourModelTwoPlayers())
        var data = self.makeEmptyData()
        data[3][3].color = .red
        _ = optimizedModel.isThereAWinner(from: .redTurn,
                                                  with: data,
                                                  insertedAt: IndexPath(item: 3, section: 3))
        data[2][4].color = .red
        _ = optimizedModel.isThereAWinner(from: .redTurn,
                                                  with: data,
                                                  insertedAt: IndexPath(item: 4, section: 2))
        data[1][5].color = .red
        _ = optimizedModel.isThereAWinner(from: .redTurn,
                                                  with: data,
                                                  insertedAt: IndexPath(item: 5, section: 1))
        data[4][2].color = .red
        let winner = optimizedModel.isThereAWinner(from: .redTurn,
                                                  with: data,
                                                  insertedAt: IndexPath(item: 2, section: 4))
        XCTAssertTrue(winner.0)
        XCTAssertFalse(winner.1.isEmpty)
        XCTAssertTrue(winner.1.count == 4)
    }

    func testCheckingDiagonally() {
        let optimizedModel = OptimizedBoardModel(model: ConnectFourModelTwoPlayers())
        var data = self.makeEmptyData()
        data[3][3].color = .red
        _ = optimizedModel.isThereAWinner(from: .redTurn,
                                                  with: data,
                                                  insertedAt: IndexPath(item: 3, section: 3))
        data[4][4].color = .red
        _ = optimizedModel.isThereAWinner(from: .redTurn,
                                                  with: data,
                                                  insertedAt: IndexPath(item: 4, section: 4))
        
        data[5][5].color = .red
        _ = optimizedModel.isThereAWinner(from: .redTurn,
                                                  with: data,
                                                  insertedAt: IndexPath(item: 5, section: 5))
        data[2][2].color = .red
        let winner = optimizedModel.isThereAWinner(from: .redTurn,
                                                  with: data,
                                                  insertedAt: IndexPath(item: 5, section: 5))
        
        XCTAssertTrue(winner.0)
        XCTAssertFalse(winner.1.isEmpty)
        XCTAssertTrue(winner.1.count == 4)
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
