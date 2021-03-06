//
//  ConnectFiveModel.swift
//  ConnectFour
//
//  Created by Gabriel Soria Souza on 28/09/21.
//

struct ConnectFiveModel: BoardModel {
    var numberOfLines: Int {
        6
    }
    var numberOfCollums: Int {
        7
    }
    var magicSequence: Int {
        5
    }
    var intellgentSelection: Bool {
        true
    }
}

struct ConnectFiveModelTwoPlayers: BoardModel {
    var numberOfLines: Int {
        6
    }
    var numberOfCollums: Int {
        7
    }
    var magicSequence: Int {
        5
    }
    var intellgentSelection: Bool {
        false
    }
}

struct ConnectFiveModelTwoPlayersSevenEight: BoardModel {
    var numberOfLines: Int {
        10
    }
    var numberOfCollums: Int {
        11
    }
    var magicSequence: Int {
        8
    }
    var intellgentSelection: Bool {
        false
    }
}
