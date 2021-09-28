//
//  ConnectFiveTests.swift
//  ConnectFourTest
//
//  Created by Gabriel Soria Souza on 27/09/21.
//

import XCTest
@testable import ConnectFour

class ConnectFiveTests: XCTestCase {
    
    var sut: BoardGameModel?
    var sutDelegate: BoardDataSourceForTest?
    var model: BoardModel?

    override func setUpWithError() throws {
        //
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.sutDelegate = nil
        self.model = nil
    }

    private func makeSutConnectFive() {
        self.model = ConnectFiveModelTwoPlayers()
        self.sutDelegate = BoardDataSourceForTest()
        self.sut = BoardGameModel(model: self.model!)
        self.sut?.delegate = self.sutDelegate
    }
    
    private func insertAndTakeTurn(at: IndexPath) {
        self.sut?.addItem(at: at,
                          turn: self.sutDelegate!.state,
                          dataSet: self.sutDelegate!.dataSet)
        self.sut?.analyzeGameResultAndTakeTurn(from: self.sutDelegate!.state,
                                               with: self.sutDelegate!.dataSet, insertedAt: at)
    }

    func testConnectFiveHorizontally() {
        self.makeSutConnectFive()
        self.sut?.initialSetup()
        self.sut?.newGame()
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 2, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 3, section: 0))
        
        //check result
        XCTAssertTrue(self.sutDelegate!.state == .yellowTurn)

        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 3, section: 0))
        
        //check result
        XCTAssertTrue(self.sutDelegate!.state == .redTurn)

        //red
        self.insertAndTakeTurn(at: IndexPath(item: 4, section: 0))

        XCTAssertTrue(self.sutDelegate!.state == .over)
        XCTAssertTrue(self.sutDelegate!.winner! == .red)
    }
    
    func testConnectFiveVertically() {
        self.makeSutConnectFive()
        self.sut?.initialSetup()
        self.sut?.newGame()
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        //red
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))
        
        //check result
        XCTAssertTrue(self.sutDelegate!.state == .yellowTurn)

        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        
        //check result
        XCTAssertTrue(self.sutDelegate!.state == .redTurn)

        //red
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))

        XCTAssertTrue(self.sutDelegate!.state == .over)
        XCTAssertTrue(self.sutDelegate!.winner! == .red)
    }
}
