//
//  MainView.swift
//  ConnectFour
//
//  Created by Gabriel Soria Souza on 25/09/21.
//

import AppKit

protocol MainViewDelegate: AnyObject {
    func didTapNewGame(_ mainView: MainView, from state: BoardGameViewController.GameState)
}

final class MainView: NSView {
    var state: BoardGameViewController.GameState {
        didSet {
            self.updateFrom(state: state)
        }
    }

    weak var delegate: MainViewDelegate?

    lazy var newGameButton: NSButton = {
        let button = NSButton(title: MainView.TitlesAndNames.newGame.rawValue,
                              target: self,
                              action: #selector(newGameAction))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.wantsLayer = true
        button.layer?.backgroundColor = NSColor.blue.cgColor
        button.layer?.cornerRadius = 20
        return button
    }()

    lazy var gameStateLabel: NSTextField = {
        let textField = NSTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isEditable = false
        textField.isSelectable = false
        textField.isBezeled = false
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.alignment = .center
        textField.font = NSFont.systemFont(ofSize: 20)
        return textField
    }()
    
    lazy var statusLabel: NSTextField = {
        let textField = NSTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isEditable = false
        textField.isSelectable = false
        textField.isBezeled = false
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.alignment = .center
        textField.isHidden = true
        textField.stringValue = TitlesAndNames.wait.rawValue
        textField.font = NSFont.systemFont(ofSize: 20)
        return textField
    }()

    lazy var board: NSCollectionView = {
        let collectionView = NSCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = true
        collectionView.isSelectable = false
        return collectionView
    }()

    init(with state: BoardGameViewController.GameState) {
        self.state = state
        super.init(frame: NSRect(x: 0, y: 0, width: 700, height: 700))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func newGameAction() {
        self.delegate?.didTapNewGame(self, from: self.state)
    }
    
    func updateFrom(state: BoardGameViewController.GameState) {
        self.setTitle(from: state)
    }
    
    func updateStatusLabel(winner: Coin.CoinColor? = nil) {
        self.statusLabel.isHidden.toggle()
        if let winner = winner {
            self.statusLabel.stringValue = self.winnerFromCoin(winner)
        }
    }
    
    func initialSetup() {
        self.setTitle(from: self.state)
        self.setupAttributes()
        self.setupLayout()
        self.configureCollectionViewLayoutAndBackground()
        self.registerCollectionViewCell()
    }
    
    func updateBoard(at indexPath: IndexPath) {
        self.board.reloadItems(at: [indexPath])
    }
    
    func updateBoard() {
        self.statusLabel.stringValue = TitlesAndNames.wait.rawValue
        self.statusLabel.isHidden = true
        self.board.layer?.sublayers?.removeAll(where: { lay in
            lay is CAShapeLayer
        })
        self.board.isSelectable = true
        self.board.reloadData()
    }
    
    private func registerCollectionViewCell() {
        self.board.register(CoinCollectionViewItem.self,
                                      forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: MainView.TitlesAndNames.itemID.rawValue))
    }
    
    private func setupLayout() {
        //collection view
        self.addSubview(self.board)
        self.board.topAnchor.constraint(equalTo: self.topAnchor,
                                                 constant: 100).isActive = true
        self.board.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                     constant: 50).isActive = true
        self.board.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                    constant: -100).isActive = true
        self.board.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                      constant: -50).isActive = true
        
        //new game button
        self.addSubview(self.newGameButton)
        self.newGameButton.bottomAnchor.constraint(equalTo: self.board.topAnchor,
                                                   constant: -20).isActive = true
        self.newGameButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        self.newGameButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.newGameButton.leadingAnchor.constraint(equalTo: self.board.leadingAnchor).isActive = true
        
        //state label
        self.addSubview(self.gameStateLabel)
        self.gameStateLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.gameStateLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.gameStateLabel.bottomAnchor.constraint(equalTo: self.board.topAnchor, constant: -20).isActive = true
        self.gameStateLabel.centerXAnchor.constraint(equalTo: self.board.centerXAnchor).isActive = true
        
        //
        self.addSubview(self.statusLabel)
        self.statusLabel.topAnchor.constraint(equalTo: self.board.bottomAnchor, constant: 10).isActive = true
        self.statusLabel.widthAnchor.constraint(equalTo: self.board.widthAnchor).isActive = true
        self.statusLabel.centerXAnchor.constraint(equalTo: self.board.centerXAnchor).isActive = true
        self.statusLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                 constant: -5).isActive = true
    }
    
    private func setupAttributes() {
        //view attributes
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.white.cgColor
    }

    private func configureCollectionViewLayoutAndBackground() {
        //layout
        let spacing: CGFloat = 7.5
        let collectionWidth = 600
        let collectionHeight = 500
        let collectionHeightItems = 6
        let collectionWidthItems = 7
        let flowLayout = NSCollectionViewFlowLayout()
        let itemWidth = (collectionWidth / collectionWidthItems) - 7
        let itemHeight = (collectionHeight / collectionHeightItems) - 7
        flowLayout.itemSize = NSSize(width: itemWidth , height: itemHeight)
        flowLayout.sectionInset = NSEdgeInsets(top: 6.5, left: spacing,
                                               bottom: 0, right: spacing)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        self.board.collectionViewLayout = flowLayout
        
        //background image
        guard let image = NSImage(named: .grid) else { return }
        let imageView = NSImageView(image: image)
        imageView.imageScaling = .scaleAxesIndependently

        self.board.backgroundView = imageView
        self.board.backgroundColors = [.white]
    }
    
    func setTitle(from state: BoardGameViewController.GameState) {
        switch state {
        case .notStarted:
            self.gameStateLabel.stringValue = TitlesAndNames.startNewGame.rawValue
        case .over:
            self.gameStateLabel.stringValue = TitlesAndNames.over.rawValue
        case .redTurn:
            self.gameStateLabel.stringValue = TitlesAndNames.redTurn.rawValue
        case .yellowTurn:
            self.gameStateLabel.stringValue = TitlesAndNames.yellowTurn.rawValue
        }
    }
    
    private func winnerFromCoin(_ coin: Coin.CoinColor) -> String {
        switch coin {
        case .red:
            return TitlesAndNames.winnerRed.rawValue
        case .yellow:
            return TitlesAndNames.winnerYellow.rawValue
        default:
            return TitlesAndNames.wait.rawValue
        }
    }
    
    func drawLine(from: IndexPath, to: IndexPath, color: Coin.CoinColor) {
        self.board.drawLine(from: from, to: to, strokeColor: color.nscolor())
    }
}

extension MainView {
    enum TitlesAndNames: String {
        case newGame = "New Game"
        case startNewGame = "Start a new game"
        case redTurn = "Red Turn"
        case yellowTurn = "Yellow Turn"
        case over = "Game Over"
        case itemID = "CoinItem"
        case wait = "Wait for your turn"
        case winnerRed = "Red is the winner"
        case winnerYellow = "Yellow is the winner"
    }
}
