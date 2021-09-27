//
//  BoardModelTests.swift
//  ConnectFourTests
//
//  Created by Gabriel Soria Souza on 27/09/21.
//

import XCTest
@testable import ConnectFour

class BoardModelTests: XCTestCase {

    var sut: BoardGameModel?
    var sutDelegate: BoardDataSourceForTest?
    var model: BoardModel?
    
    override func setUpWithError() throws {
        //
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.sutDelegate = nil
    }
    
    func testInitialSetup() {
        self.makeSutConnectFour()
        self.sut?.initialSetup()
        self.sut?.newGame()
        XCTAssertEqual(self.sutDelegate!.dataSet.count, self.model!.numberOfLines)
        XCTAssertEqual(self.sutDelegate!.dataSet.first!.count, self.model!.numberOfCollums)
    }
    
    func testTryToInsertWhenNotStarted() {
        self.makeSutConnectFour()
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: sutDelegate!.state,
                          dataSet: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate!.dataSet.isEmpty)
    }

    func testOneInsertion() {
        self.makeSutConnectFourTwoPlayers()
        self.sut?.initialSetup()
        self.sut?.newGame()
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][0].color == .red)
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
    }
    
    func testTakingTurnsWithTwoPlayers() {
        self.makeSutConnectFourTwoPlayers()
        self.sut?.initialSetup()
        self.sut?.newGame()
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][0].color == .red)
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[4][0].color == .yellow)
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .redTurn)
    }
    
    func insertAndTakeTurn(at: IndexPath) {
        self.sut?.addItem(at: at,
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        self.sut?.analyzeGameResultAndTakeTurn(from: self.sutDelegate!.state,
                                               with: self.sutDelegate!.dataSet)
    }
    
    func testYelloWinningDiagonallyRightUpSide() {
        self.makeSutConnectFourTwoPlayers()
        self.sut?.initialSetup()
        self.sut?.newGame()
        
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
        
        XCTAssertTrue(self.sutDelegate?.state == .over)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.first!.item == 5)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.first!.section == 0)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.last!.item == 2)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.last!.section == 3)
        XCTAssertTrue(self.sutDelegate!.winner! == .yellow)
    }
    
    func testYelloWinningDiagonallyLeftUpSide() {
        self.makeSutConnectFourTwoPlayers()
        self.sut?.initialSetup()
        self.sut?.newGame()
        
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
        
        XCTAssertTrue(self.sutDelegate?.state == .over)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.first!.item == 1)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.first!.section == 0)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.last!.item == 4)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.last!.section == 3)
        XCTAssertTrue(self.sutDelegate!.winner! == .yellow)
    }
    
    
    func testRedWinningDiagonallyRightToLeft() {
        self.makeSutConnectFourTwoPlayers()
        self.sut?.initialSetup()
        self.sut?.newGame()
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
        XCTAssertTrue(self.sutDelegate?.state == .over)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.first!.item == 6)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.first!.section == 2)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.last!.item == 3)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.last!.section == 5)
        XCTAssertTrue(self.sutDelegate!.winner! == .red)
    }
    
    func testYellowWinningDiagonally() {
        self.makeSutConnectFourTwoPlayers()
        self.sut?.initialSetup()
        self.sut?.newGame()
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
        XCTAssertTrue(self.sutDelegate?.state == .over)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.first!.item == 0)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.first!.section == 2)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.last!.item == 3)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.last!.section == 5)
        XCTAssertTrue(self.sutDelegate!.winner! == .yellow)
    }
    
    func testRedWinningDiagonally() {
        self.makeSutConnectFourTwoPlayers()
        self.sut?.initialSetup()
        self.sut?.newGame()
        //red
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][0].color == .red)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        //yellow
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[4][0].color == .yellow)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .redTurn)
        //red
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[3][0].color == .red)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        //yellow
        self.sut?.addItem(at: IndexPath(item: 2, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][2].color == .yellow)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .redTurn)
        //red
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[2][0].color == .red)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        //yellow
        self.sut?.addItem(at: IndexPath(item: 1, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][1].color == .yellow)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .redTurn)
        //red
        self.sut?.addItem(at: IndexPath(item: 3, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][3].color == .red)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        //yellow
        self.sut?.addItem(at: IndexPath(item: 1, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[4][1].color == .yellow)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .redTurn)
        //red
        self.sut?.addItem(at: IndexPath(item: 2, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[4][2].color == .red)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        //yellow
        self.sut?.addItem(at: IndexPath(item: 3, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[4][3].color == .yellow)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .redTurn)
        //red
        self.sut?.addItem(at: IndexPath(item: 1, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[3][1].color == .red)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .over)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.first!.item == 0)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.first!.section == 2)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.last!.item == 3)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.last!.section == 5)
        XCTAssertTrue(self.sutDelegate!.winner! == .red)
    }
    
    func testYellowWinningHorizontally() {
        self.makeSutConnectFourTwoPlayers()
        self.sut?.initialSetup()
        self.sut?.newGame()
        //red
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][0].color == .red)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        //yellow
        self.sut?.addItem(at: IndexPath(item: 6, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][6].color == .yellow)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .redTurn)
        //red
        self.sut?.addItem(at: IndexPath(item: 1, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][1].color == .red)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        //yellow
        self.sut?.addItem(at: IndexPath(item: 5, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][5].color == .yellow)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .redTurn)
        //red
        self.sut?.addItem(at: IndexPath(item: 1, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[4][1].color == .red)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        //yellow
        self.sut?.addItem(at: IndexPath(item: 4, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][4].color == .yellow)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .redTurn)
        //red
        self.sut?.addItem(at: IndexPath(item: 1, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[3][1].color == .red)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        //yellow
        self.sut?.addItem(at: IndexPath(item: 3, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][3].color == .yellow)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .over)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.first!.item == 3)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.first!.section == 5)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.last!.item == 6)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.last!.section == 5)
        XCTAssertTrue(self.sutDelegate!.winner! == .yellow)
    }
    
    func testRedWinningHorizontally() {
        self.makeSutConnectFourTwoPlayers()
        self.sut?.initialSetup()
        self.sut?.newGame()
        //red
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][0].color == .red)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        //yellow
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[4][0].color == .yellow)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .redTurn)
        //red
        self.sut?.addItem(at: IndexPath(item: 1, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][1].color == .red)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        //yellow
        self.sut?.addItem(at: IndexPath(item: 1, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[4][1].color == .yellow)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .redTurn)
        //red
        self.sut?.addItem(at: IndexPath(item: 2, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][2].color == .red)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        //yellow
        self.sut?.addItem(at: IndexPath(item: 2, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[4][2].color == .yellow)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .redTurn)
        //red
        self.sut?.addItem(at: IndexPath(item: 3, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][3].color == .red)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .over)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.first!.item == 0)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.first!.section == 5)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.last!.item == 3)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.last!.section == 5)
        XCTAssertTrue(self.sutDelegate!.winner! == .red)
    }
    
    func testYellowWinningVertically() {
        self.makeSutConnectFourTwoPlayers()
        self.sut?.initialSetup()
        self.sut?.newGame()
        //red
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][0].color == .red)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        //yellow
        self.sut?.addItem(at: IndexPath(item: 1, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][1].color == .yellow)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .redTurn)
        //red
        self.sut?.addItem(at: IndexPath(item: 6, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][6].color == .red)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        //yellow
        self.sut?.addItem(at: IndexPath(item: 1, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[4][1].color == .yellow)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .redTurn)
        //red
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[4][0].color == .red)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        //yellow
        self.sut?.addItem(at: IndexPath(item: 1, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[3][1].color == .yellow)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .redTurn)
        //red
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[3][0].color == .red)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        //yellow
        self.sut?.addItem(at: IndexPath(item: 1, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[2][1].color == .yellow)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .over)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.first!.item == 1)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.first!.section == 2)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.last!.item == 1)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.last!.section == 5)
        XCTAssertTrue(self.sutDelegate!.winner! == .yellow)
    }
    
    func testRedWinningVertically() {
        self.makeSutConnectFourTwoPlayers()
        self.sut?.initialSetup()
        self.sut?.newGame()
        //red
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][0].color == .red)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        //yellow
        self.sut?.addItem(at: IndexPath(item: 1, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][1].color == .yellow)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .redTurn)
        //red
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[4][0].color == .red)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        //yellow
        self.sut?.addItem(at: IndexPath(item: 1, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[4][1].color == .yellow)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .redTurn)
        //red
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[3][0].color == .red)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        //yellow
        self.sut?.addItem(at: IndexPath(item: 1, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[3][1].color == .yellow)
        //turn
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .redTurn)
        //red
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[2][0].color == .red)
        //finishing
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate!.state == .over)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.first!.item == 0)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.first!.section == 2)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.last!.item == 0)
        XCTAssertTrue(self.sutDelegate!.winnerIndexes.last!.section == 5)
        XCTAssertTrue(self.sutDelegate!.winner! == .red)
    }
    
    func testInsertFirstColumn() {
        self.makeSutConnectFourTwoPlayers()
        self.sut?.initialSetup()
        self.sut?.newGame()
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[5][0].color == .red)
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[4][0].color == .yellow)
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .redTurn)
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[3][0].color == .red)
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[2][0].color == .yellow)
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .redTurn)
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[1][0].color == .red)
        self.sut?.analyzeGameResultAndTakeTurn(from: sutDelegate!.state,
                                               with: sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.state == .yellowTurn)
        self.sut?.addItem(at: IndexPath(item: 0, section: 0),
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        XCTAssertTrue(self.sutDelegate?.dataSet[0][0].color == .yellow)
    }

    private func makeSutConnectFour() {
        self.model = ConnectFourModel()
        self.sutDelegate = BoardDataSourceForTest()
        self.sut = BoardGameModel(model: self.model!)
        self.sut?.delegate = self.sutDelegate
    }
    
    private func makeSutConnectFourTwoPlayers() {
        self.model = ConnectFourModelTwoPlayers()
        self.sutDelegate = BoardDataSourceForTest()
        self.sut = BoardGameModel(model: self.model!)
        self.sut?.delegate = self.sutDelegate
    }
}
