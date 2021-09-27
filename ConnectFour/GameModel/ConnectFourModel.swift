//
//  ConnectFourModel.swift
//  ConnectFour
//
//  Created by Gabriel Soria Souza on 27/09/21.
//

struct ConnectFourModel: BoardModel {
    var numberOfLines: Int {
        6
    }
    var numberOfCollums: Int {
        7
    }
    var magicSequence: Int {
        4
    }
    var intellgentSelection: Bool {
        true
    }
}
