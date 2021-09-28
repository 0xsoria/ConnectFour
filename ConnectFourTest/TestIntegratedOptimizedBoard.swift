//
//  TestIntegratedOptimizedBoard.swift
//  ConnectFourTest
//
//  Created by Gabriel Soria Souza on 28/09/21.
//

import XCTest
@testable import ConnectFour

class TestIntegratedOptimizedBoard: XCTestCase {

    var controller: BoardController!

    override func setUpWithError() throws {
        //
    }

    override func tearDownWithError() throws {
        //
    }
    
    private func makeSutConnectFour() {
        self.controller = BoardController()
        self.controller.model = ConnectFourModel()
        self.controller.sutDelegate = BoardDataSourceForTest()
        self.controller.sut = OptimizedBoardModel(model: self.controller.model!)
        self.controller.sut?.delegate = self.controller.sutDelegate
        self.controller.sutDelegate?.delegate = self.controller
    }
    
    private func makeSutConnectFourTwoPlayers() {
        self.controller = BoardController()
        self.controller.model = ConnectFourModelTwoPlayers()
        self.controller.sutDelegate = BoardDataSourceForTest()
        self.controller.sut = OptimizedBoardModel(model: self.controller.model!)
        self.controller.sut?.delegate = self.controller!.sutDelegate
        self.controller.sutDelegate?.delegate = self.controller
    }
    
    func insertAndTakeTurn(at: IndexPath) {
        self.controller.sut?.addItem(at: at,
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
    }
    
    func testInitialSetup() {
        self.makeSutConnectFour()
        self.controller.sut?.initialSetup()
        self.controller.sut?.newGame()
        XCTAssertEqual(self.controller.sutDelegate!.dataSet.count, self.controller.model!.numberOfLines)
        XCTAssertEqual(self.controller.sutDelegate!.dataSet.first!.count, self.controller.model!.numberOfCollums)
    }
    
    func testTryToInsertWhenNotStarted() {
        self.makeSutConnectFour()
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: controller.sutDelegate!.state,
                          dataSet: controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate!.dataSet.isEmpty)
    }
    
    func testOneInsertion() {
        self.makeSutConnectFourTwoPlayers()
        self.controller.sut?.initialSetup()
        self.controller.sut?.newGame()
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][0].color == .red)
        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
    }
    
    func testTakingTurnsWithTwoPlayers() {
        self.makeSutConnectFourTwoPlayers()
        self.controller.sut?.initialSetup()
        self.controller.sut?.newGame()
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][0].color == .red)
        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.controller.sutDelegate!.state,
                          dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[4][0].color == .yellow)
        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
    }
    
    func testTie() {
        self.makeSutConnectFourTwoPlayers()
        self.controller.sut?.initialSetup()
        self.controller.sut?.newGame()
        //first row
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 6, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 5, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 3, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 4, section: 0))
        
        //second row
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 6, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 4, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 3, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 5, section: 0))
        
        //third row
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 4, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 5, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 3, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 6, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 3, section: 0))
        
        //fourth row
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 4, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 5, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 6, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 3, section: 0))
        
        
        //fifth row
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 4, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 5, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 3, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 6, section: 0))
        
        //sixth row
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 6, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 5, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 4, section: 0))
        
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 3, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        
        var emptyIndexes: [Coin] = []
        for coin in self.controller.sutDelegate!.dataSet.first! {
            if coin.color == .empty {
                emptyIndexes.append(coin)
            }
        }
        XCTAssertTrue(emptyIndexes.isEmpty)
        XCTAssertTrue(self.controller.sutDelegate?.state == .over)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.isEmpty)
        XCTAssertNil(self.controller.sutDelegate!.winner)
    }
    
    func testYelloWinningDiagonallyRightUpSide() {
        self.makeSutConnectFourTwoPlayers()
        self.controller.sut?.initialSetup()
        self.controller.sut?.newGame()
        
        //column 6
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 5, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 5, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 5, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 5, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 5, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 5, section: 0))
        
        //column 3
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 3, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 3, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 3, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 3, section: 0))
        
        //column 2
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        
        //column 2
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        
        //column 0
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        
        //column 2
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        
        //column 0
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        
        //column 4
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 4, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 4, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 4, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 4, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 4, section: 0))
        
        XCTAssertTrue(self.controller.sutDelegate?.state == .over)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.item == 5)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.section == 0)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.item == 2)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.section == 3)
        XCTAssertTrue(self.controller.sutDelegate!.winner! == .yellow)
    }
    
    func testYelloWinningDiagonallyLeftUpSide() {
        self.makeSutConnectFourTwoPlayers()
        self.controller.sut?.initialSetup()
        self.controller.sut?.newGame()
        
        //column 1
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        
        //column 3
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 3, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 3, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 3, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 3, section: 0))
        
        //column 4
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 4, section: 0))
        
        //column 2
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        
        //column 4
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 4, section: 0))
        
        //column 2
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        
        //column 6
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 6, section: 0))
        
        //column 4
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 4, section: 0))
        
        //column 6
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 6, section: 0))
        //column 2
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        
        XCTAssertTrue(self.controller.sutDelegate?.state == .over)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.item == 1)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.section == 0)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.item == 4)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.section == 3)
        XCTAssertTrue(self.controller.sutDelegate!.winner! == .yellow)
    }
    
    func testRedWinningDiagonallyRightToLeft() {
        self.makeSutConnectFourTwoPlayers()
        self.controller.sut?.initialSetup()
        self.controller.sut?.newGame()
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 6, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 6, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 3, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 6, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 6, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 5, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 5, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 5, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 4, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 5, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 4, section: 0))
        XCTAssertTrue(self.controller.sutDelegate?.state == .over)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.item == 6)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.section == 2)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.item == 3)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.section == 5)
        XCTAssertTrue(self.controller.sutDelegate!.winner! == .red)
    }
    
    func testYellowWinningDiagonally() {
        self.makeSutConnectFourTwoPlayers()
        self.controller.sut?.initialSetup()
        self.controller.sut?.newGame()
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 3, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        XCTAssertTrue(self.controller.sutDelegate?.state == .over)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.item == 0)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.section == 2)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.item == 3)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.section == 5)
        XCTAssertTrue(self.controller.sutDelegate!.winner! == .yellow)
    }
    
    func testRedWinningDiagonally() {
        self.makeSutConnectFourTwoPlayers()
        self.controller.sut?.initialSetup()
        self.controller.sut?.newGame()
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][0].color == .red)
        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[4][0].color == .yellow)
        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.controller.sutDelegate!.state,
                          dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[3][0].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 2, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][2].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[2][0].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 1, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][1].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 3, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][3].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 1, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[4][1].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 2, section: 0),
                          turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[4][2].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 3, section: 0),
                                    turn: self.controller.sutDelegate!.state,
                                    dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[4][3].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 1, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[3][1].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .over)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.item == 0)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.section == 2)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.item == 3)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.section == 5)
        XCTAssertTrue(self.controller.sutDelegate!.winner! == .red)
    }
    
    func testYellowWinningDiagonally2() {
        self.makeSutConnectFourTwoPlayers()
        self.controller.sut?.initialSetup()
        self.controller.sut?.newGame()
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 3, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        XCTAssertTrue(self.controller.sutDelegate?.state == .over)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.item == 0)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.section == 2)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.item == 3)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.section == 5)
        XCTAssertTrue(self.controller.sutDelegate!.winner! == .yellow)
    }
    
    func testRedWinningDiagonally2() {
        self.makeSutConnectFourTwoPlayers()
        self.controller.sut?.initialSetup()
        self.controller.sut?.newGame()
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.controller.sutDelegate!.state,
                          dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][0].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.controller.sutDelegate!.state,
                          dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[4][0].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.controller.sutDelegate!.state,
                          dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[3][0].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 2, section: 0),
                          turn: self.controller.sutDelegate!.state,
                          dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][2].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.controller.sutDelegate!.state,
                          dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[2][0].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 1, section: 0),
                          turn: self.controller.sutDelegate!.state,
                          dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][1].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 3, section: 0),
                          turn: self.controller.sutDelegate!.state,
                          dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][3].color == .red)
 
        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 1, section: 0),
                          turn: self.controller.sutDelegate!.state,
                          dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[4][1].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 2, section: 0),
                          turn: self.controller.sutDelegate!.state,
                          dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[4][2].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 3, section: 0),
                          turn: self.controller.sutDelegate!.state,
                          dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[4][3].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 1, section: 0),
                          turn: self.controller.sutDelegate!.state,
                          dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[3][1].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .over)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.item == 0)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.section == 2)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.item == 3)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.section == 5)
        XCTAssertTrue(self.controller.sutDelegate!.winner! == .red)
    }
    
    func testYellowWinningHorizontally() {
        self.makeSutConnectFourTwoPlayers()
        self.controller.sut?.initialSetup()
        self.controller.sut?.newGame()
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][0].color == .red)
        
        
        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 6, section: 0),
                          turn: self.controller.sutDelegate!.state,
                          dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][6].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 1, section: 0),
                          turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][1].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 5, section: 0),
                           turn: self.controller.sutDelegate!.state,
                           dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][5].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 1, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[4][1].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 4, section: 0),
                          turn: self.controller.sutDelegate!.state,
                          dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][4].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 1, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[3][1].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 3, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][3].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .over)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.item == 3)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.section == 5)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.item == 6)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.section == 5)
        XCTAssertTrue(self.controller.sutDelegate!.winner! == .yellow)
    }
    
    func testRedWinningHorizontally() {
        self.makeSutConnectFourTwoPlayers()
        self.controller.sut?.initialSetup()
        self.controller.sut?.newGame()
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][0].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[4][0].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 1, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][1].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 1, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[4][1].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 2, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][2].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 2, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[4][2].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 3, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][3].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .over)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.item == 0)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.section == 5)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.item == 3)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.section == 5)
        XCTAssertTrue(self.controller.sutDelegate!.winner! == .red)
    }
    
    func testYellowWinningVertically() {
        self.makeSutConnectFourTwoPlayers()
        self.controller.sut?.initialSetup()
        self.controller.sut?.newGame()
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][0].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 1, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][1].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 6, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][6].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 1, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[4][1].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[4][0].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 1, section: 0),
                          turn: self.controller.sutDelegate!.state,
                          dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[3][1].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[3][0].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 1, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[2][1].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .over)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.item == 1)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.section == 2)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.item == 1)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.section == 5)
        XCTAssertTrue(self.controller.sutDelegate!.winner! == .yellow)
    }
    
    func testRedWinningVertically() {
        self.makeSutConnectFourTwoPlayers()
        self.controller.sut?.initialSetup()
        self.controller.sut?.newGame()
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][0].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 1, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][1].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[4][0].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 1, section: 0),
                          turn: self.controller.sutDelegate!.state,
                          dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[4][1].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.controller.sutDelegate!.state,
                          dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[3][0].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        //yellow
        self.controller.sut?.addItem(at: IndexPath(item: 1, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[3][1].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        //red
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[2][0].color == .red)

        XCTAssertTrue(self.controller.sutDelegate!.state == .over)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.item == 0)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.first!.section == 2)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.item == 0)
        XCTAssertTrue(self.controller.sutDelegate!.winnerIndexes.last!.section == 5)
        XCTAssertTrue(self.controller.sutDelegate!.winner! == .red)
    }
    
    func testInsertFirstColumn() {
        self.makeSutConnectFourTwoPlayers()
        self.controller.sut?.initialSetup()
        self.controller.sut?.newGame()
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[5][0].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[4][0].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[3][0].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[2][0].color == .yellow)

        XCTAssertTrue(self.controller.sutDelegate?.state == .redTurn)
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[1][0].color == .red)

        XCTAssertTrue(self.controller.sutDelegate?.state == .yellowTurn)
        self.controller.sut?.addItem(at: IndexPath(item: 0, section: 0),
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
        XCTAssertTrue(self.controller.sutDelegate?.dataSet[0][0].color == .yellow)
    }
}
