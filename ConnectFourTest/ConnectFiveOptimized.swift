//
//  ConnectFiveOptimized.swift
//  ConnectFourTest
//
//  Created by Gabriel Soria Souza on 28/09/21.
//

import XCTest
@testable import ConnectFour

class ConnectFiveOptimized: XCTestCase {
    
    var controller: BoardController!

    
    private func makeSutConnectFiveTwoPlayers() {
        self.controller = BoardController()
        self.controller.model = ConnectFiveModelTwoPlayers()
        self.controller.sutDelegate = BoardDataSourceForTest()
        self.controller.sut = OptimizedBoardModel(model: self.controller.model!)
        self.controller.sut?.delegate = self.controller!.sutDelegate
        self.controller.sutDelegate?.delegate = self.controller
    }
    
    private func insertAndTakeTurn(at: IndexPath) {
        self.controller.sut?.addItem(at: at,
                                     turn: self.controller.sutDelegate!.state,
                                     dataSet: self.controller.sutDelegate!.dataSet)
    }

    override func setUpWithError() throws {
        //
    }

    override func tearDownWithError() throws {
        self.controller.sut = nil
        self.controller.sutDelegate = nil
        self.controller.model = nil
    }
    
    func testConnectFiveHorizontally() {
        self.makeSutConnectFiveTwoPlayers()
        self.controller.sut?.initialSetup()
        self.controller.sut?.newGame()
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
        XCTAssertTrue(self.controller.sutDelegate!.state == .yellowTurn)

        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 3, section: 0))
        
        //check result
        XCTAssertTrue(self.controller.sutDelegate!.state == .redTurn)

        //red
        self.insertAndTakeTurn(at: IndexPath(item: 4, section: 0))

        XCTAssertTrue(self.controller.sutDelegate!.state == .over)
        XCTAssertTrue(self.controller.sutDelegate!.winner! == .red)
    }
    
    func testConnectFiveVertically() {
        self.makeSutConnectFiveTwoPlayers()
        self.controller.sut?.initialSetup()
        self.controller.sut?.newGame()
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
        XCTAssertTrue(self.controller.sutDelegate!.state == .yellowTurn)

        //yellow
        self.insertAndTakeTurn(at: IndexPath(item: 1, section: 0))
        
        //check result
        XCTAssertTrue(self.controller.sutDelegate!.state == .redTurn)

        //red
        self.insertAndTakeTurn(at: IndexPath(item: 0, section: 0))

        XCTAssertTrue(self.controller.sutDelegate!.state == .over)
        XCTAssertTrue(self.controller.sutDelegate!.winner! == .red)
    }
}
