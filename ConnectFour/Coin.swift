//
//  Coin.swift
//  ConnectFour
//
//  Created by Gabriel Soria Souza on 25/09/21.
//

import class AppKit.NSColor

struct Coin {
    var color: CoinColor

    enum CoinColor {
        case red
        case yellow
        case empty
        
        func nscolor() -> NSColor {
            switch self {
            case .empty:
                return .white
            case .red:
                return .red
            case .yellow:
                return .yellow
            }
        }
    }
    
    init(color: CoinColor) {
        self.color = color
    }
    
}
