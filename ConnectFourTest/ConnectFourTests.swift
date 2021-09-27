//
//  ConnectFourTests.swift
//  ConnectFourTests
//
//  Created by Gabriel Soria Souza on 25/09/21.
//

import XCTest
@testable import ConnectFour

class ConnectFourTests: XCTestCase {

    var sut: BoardGameViewController?

    override func setUpWithError() throws {
        self.sut = self.makeSut()
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }
    
    func testInitialSetup() {
        self.loadSut()
        XCTAssertTrue(self.sut!.mainView.state == .notStarted)
        XCTAssertTrue(self.sut!.mainView.board.delegate != nil)
        XCTAssertTrue(self.sut!.mainView.board.dataSource != nil)
        XCTAssertTrue(self.sut!.mainView.board.numberOfSections == 6)
        XCTAssertTrue(self.sut!.mainView.board.numberOfItems(inSection: 0) == 7)
        XCTAssertTrue((self.sut!.mainView.board.backgroundView as? NSImageView)?.image?.name() == .grid)
        XCTAssertTrue(self.sut!.mainView.gameStateLabel.stringValue == MainView.TitlesAndNames.startNewGame.rawValue)
    }
    
    func testMakeNewGame() {
        self.loadSut()
        self.sut?.mainView.newGameAction()
        XCTAssertTrue(self.sut!.dataSource.dataSet.count == 6)
        XCTAssertTrue(self.sut!.dataSource.dataSet.first!.count == 7)
        XCTAssertTrue(self.sut!.mainView.board.numberOfSections == 6)
        XCTAssertTrue(self.sut!.mainView.board.numberOfItems(inSection: 0) == 7)
        XCTAssertTrue(self.sut!.mainView.gameStateLabel.stringValue == MainView.TitlesAndNames.redTurn.rawValue)
        XCTAssertTrue(self.sut!.mainView.state == .redTurn)
    }

    func loadSut() {
        self.sut?.loadView()
        self.sut?.viewDidLoad()
    }

    func makeSut() -> BoardGameViewController {
        BoardGameViewController()
    }
}
