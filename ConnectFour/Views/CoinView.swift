//
//  CoinView.swift
//  ConnectFour
//
//  Created by Gabriel Soria Souza on 03/10/21.
//

import Cocoa

final class CoinView: NSView {

    private var color: NSColor

    init(color: NSColor) {
        self.color = color
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ dirtyRect: NSRect) {
        let f = CGRect(x: 10, y: 10, width: self.bounds.width - 20, height: self.bounds.height - 20)
        let path = NSBezierPath(roundedRect: f, xRadius: self.bounds.width - 20, yRadius: self.bounds.height - 20)
        self.color.setFill()
        path.fill()
    }
    
    func updateColor(color: NSColor) {
        self.color = color
    }
}

