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
