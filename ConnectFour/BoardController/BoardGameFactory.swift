//
//  BoardGameFactory.swift
//  ConnectFour
//
//  Created by Gabriel Soria Souza on 27/09/21.
//

enum MakeBoardGame {
    static func make() -> BoardGameViewController {
        let connectFour = ConnectFourModel()
        let model = OptimizedBoardModel(model: connectFour)
        return BoardGameViewController(model: model)
    }
}

enum MakeBoardGameTwoPlayers {
    static func make() -> BoardGameViewController {
        let connectFour = ConnectFourModelTwoPlayers()
        let model = OptimizedBoardModel(model: connectFour)
        return BoardGameViewController(model: model)
    }
}

enum MakeBoardGameNotOptimized {
    static func make() -> BoardGameViewController {
        let connectFour = ConnectFourModel()
        let model = BoardGameModel(model: connectFour)
        return BoardGameViewController(model: model)
    }
}

enum MakeBoardGameConnectFive {
    static func make() -> BoardGameViewController {
        let connectFour = ConnectFiveModel()
        let model = OptimizedBoardModel(model: connectFour)
        return BoardGameViewController(model: model)
    }
}

enum MakeBoardGameTwoPlayersConnectFive {
    static func make() -> BoardGameViewController {
        let connectFour = ConnectFiveModelTwoPlayers()
        let model = OptimizedBoardModel(model: connectFour)
        return BoardGameViewController(model: model)
    }
}

enum MakeBoardGameTwoPlayersConnectfiveSevenEight {
    static func make() -> BoardGameViewController {
        let connectFour = ConnectFiveModelTwoPlayersSevenEight()
        let model = OptimizedBoardModel(model: connectFour)
        return BoardGameViewController(model: model)
    }
}
