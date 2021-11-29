//
//  GridView.swift
//  ConnectFour
//
//  Created by Gabriel Soria Souza on 01/10/21.
//

import AppKit

final class GridView: NSView {
    private let path = NSBezierPath()
    private let lines: Int
    private let columns: Int
    
    init(lines: Int, columns: Int) {
        self.lines = lines
        self.columns = columns
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var gridWidthMultiple: CGFloat {
        return CGFloat(self.columns)
    }
    
    private var gridHeightMultiple : CGFloat {
        return CGFloat(self.lines)
    }
    
    private var gridWidth: CGFloat {
        return bounds.width/CGFloat(gridWidthMultiple)
    }
    
    private var gridHeight: CGFloat {
        return bounds.height/CGFloat(gridHeightMultiple)
    }
    
    private func drawGrid() {
        path.lineWidth = 5.0

        for index in 0...Int(gridWidthMultiple) {
            let start = CGPoint(x: CGFloat(index) * gridWidth, y: 0)
            let end = CGPoint(x: CGFloat(index) * gridWidth, y:bounds.height)
            path.move(to: start)
            path.line(to: end)
        }

        for index in 0...Int(gridHeightMultiple) {
            let start = CGPoint(x: 0, y: CGFloat(index) * gridHeight)
            let end = CGPoint(x: bounds.width, y: CGFloat(index) * gridHeight)
            path.move(to: start)
            path.line(to: end)
        }
        path.close()
    }
    
    override func draw(_ dirtyRect: NSRect) {
        self.drawGrid()
        NSColor.blue.setStroke()
        path.stroke()
    }
}

