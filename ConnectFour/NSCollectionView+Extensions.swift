//
//  NSCollectionView+Extensions.swift
//  ConnectFour
//
//  Created by Gabriel Soria Souza on 26/09/21.
//

import Cocoa

final class SubViewPath: NSView {}

extension NSCollectionView {
    func drawLine(from: IndexPath, to: IndexPath, strokeColor: NSColor) {
        guard let itemFrom = self.item(at: from),
              let itemTo = self.item(at: to) else { return }
        let path = NSBezierPath()
        if from > to {
            path.move(to: NSPoint(x: itemTo.view.frame.origin.x + itemTo.view.frame.size.width / 2 , y: itemTo.view.frame.origin.y + itemTo.view.frame.size.height / 2))
            path.line(to: NSPoint(x: itemFrom.view.frame.origin.x + itemFrom.view.frame.size.width / 2, y: itemFrom.view.frame.origin.y + itemFrom.view.frame.size.height / 2))
        } else {
            path.move(to: NSPoint(x: itemFrom.view.frame.origin.x + itemFrom.view.frame.size.width / 2, y: itemFrom.view.frame.origin.y + itemFrom.view.frame.size.height / 2))
            path.line(to: NSPoint(x: itemTo.view.frame.origin.x + itemTo.view.frame.size.width / 2 , y: itemTo.view.frame.origin.y + itemTo.view.frame.size.height / 2))
        }
        let layer = CAShapeLayer()

        layer.path = path.cgPath
        layer.lineWidth = 2
        layer.strokeColor = strokeColor.cgColor

        self.layer?.addSublayer(layer)
    }
}

extension NSBezierPath {

    public var cgPath: CGPath {
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)

        for i in 0 ..< elementCount {
            let type = element(at: i, associatedPoints: &points)
            switch type {
            case .moveTo:
                path.move(to: points[0])
            case .lineTo:
                path.addLine(to: points[0])
            case .curveTo:
                path.addCurve(to: points[2], control1: points[0], control2: points[1])
            case .closePath:
                path.closeSubpath()
            @unknown default:
                continue
            }
        }

        return path
    }
}
