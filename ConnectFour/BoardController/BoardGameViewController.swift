//
//  ViewController.swift
//  ConnectFour
//
//  Created by Gabriel Soria Souza on 25/09/21.
//

import Cocoa

final class BoardGameViewController: NSViewController {
    enum GameState {
        case notStarted
        case redTurn
        case yellowTurn
        case over
        
        func colorFromState() -> Coin.CoinColor {
            switch self {
            case .redTurn:
                return .red
            case .yellowTurn:
                return .yellow
            default:
                return .empty
            }
        }
    }

    let mainView = MainView(with: .notStarted)
    let model: BoardGameModel
    let dataSource = BoardDataSource()
    private let dispatchQueue = DispatchQueue(label: "com.ConnectFour")

    init(model: BoardGameModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = self.mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }

    private func initialSetup() {
        self.mainView.initialSetup()
        self.mainView.delegate = self
        self.model.delegate = self
        self.dataSource.delegate = self
        self.mainView.board.dataSource = self.dataSource
        self.mainView.board.delegate = self.dataSource
        self.model.initialSetup()
    }
}

extension BoardGameViewController: MainViewDelegate {
    func didTapNewGame(_ mainView: MainView, from state: GameState) {
        self.model.newGame()
    }
}

extension BoardGameViewController: BoardDataSourceDelegate {
    func didMakeNewGame() {
        self.mainView.updateBoard()
    }

    func didUpdate(at indexPath: IndexPath, from data: [[Coin]]) {
        self.mainView.updateBoard(at: indexPath)
        self.dispatchQueue.async {
            self.model.analyzeGameResultAndTakeTurn(from: self.mainView.state,
                                                    with: data,
                                                    insertedAt: indexPath)
        }
    }

    func didSelect(at indexPath: IndexPath, data: [[Coin]]) {
        self.dispatchQueue.async {
            self.model.addItem(at: indexPath,
                               turn: self.mainView.state,
                               dataSet: data)
        }
    }
}

extension BoardGameViewController: BoardGameDelegate {
    func shouldFinishTheGame(winner: Coin.CoinColor,
                             indexes: [IndexPath],
                             state: BoardGameViewController.GameState) {
        DispatchQueue.main.async {
            if let first = indexes.first, let last = indexes.last {
                self.mainView.drawLine(from: first, to: last, color: winner)
            }
            self.mainView.state = state
            self.mainView.updateStatusLabel(winner: winner)
        }
    }
    
    func gameOver() {
        DispatchQueue.main.async {
            self.mainView.state = .over
            self.mainView.updateStatusLabel(winner: .empty)
        }
    }
    
    func shouldUpdateTurn(_ turn: GameState) {
        DispatchQueue.main.async {
            self.mainView.state = turn
        }
    }
    
    func didStartIntelligentSelection() {
        DispatchQueue.main.async {
            self.mainView.updateStatusLabel()
        }
    }
    
    func didFinishIntelligentSelection() {
        DispatchQueue.main.async {
            self.mainView.updateStatusLabel()
        }
    }

    func shouldMakeInitialSetup(numberOfLines: Int, numberOfCollums: Int) {
        self.dataSource.startNewData(numberOfLines: numberOfLines,
                                     numberOfCollums: numberOfCollums)
        self.mainView.updateBoard(numberOfLines: numberOfLines,
                                  numberOfColumns: numberOfCollums)
    }
    
    func shouldAddItem(at indexPath: IndexPath, to color: Coin.CoinColor) {
        DispatchQueue.main.async {
            self.dataSource.updateData(at: indexPath, coinColor: color)
        }
    }
    
    func shouldStartNewGame(newState: GameState,
                         numberOfLines: Int,
                         numberOfCollums: Int) {
        self.mainView.state = newState
        self.dataSource.startNewData(numberOfLines: numberOfLines,
                                     numberOfCollums: numberOfCollums)
    }
}
