//
//  GraphView.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import UIKit

class GraphView: UIView {
    private enum Constants {
        static let cornerRadiusSize = CGSize(width: 8, height: 8)
        static let margin: CGFloat = 8
        static let topBorder: CGFloat = 50
        static let bottomBorder: CGFloat = 50
        static let colorAlpha: CGFloat = 0.5
        static let circleDiameter: CGFloat = 5.0
    }

    var startColor: UIColor = .black
    var graphPoints: [Double] = []

    override func draw(_ rect: CGRect) {
        let width = rect.width - 16
        let height = rect.height

        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: UIRectCorner.allCorners,
            cornerRadii: Constants.cornerRadiusSize
        )
        path.addClip()

        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        let colors = [startColor.cgColor]

        let colorSpace = CGColorSpaceCreateDeviceRGB()

        let colorLocations: [CGFloat] = [0.0, 1.0]

        guard let gradient = CGGradient(
            colorsSpace: colorSpace,
            colors: colors as CFArray,
            locations: colorLocations
        ) else {
            return
        }

        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(
            gradient,
            start: startPoint,
            end: endPoint,
            options: []
        )

        let margin = Constants.margin
        let columnXPoint = { (column: Int) -> CGFloat in
            let spacing = (width - margin * 2 - 4) / CGFloat((self.graphPoints.count - 1))
            return CGFloat(column) * spacing + margin + 2
        }

        let topBorder: CGFloat = Constants.topBorder
        let bottomBorder: CGFloat = Constants.bottomBorder
        let graphHeight = height - topBorder - bottomBorder
        guard let maxValue = graphPoints.max() else {
            return
        }
        let columnYPoint = { (graphPoint: Double) -> CGFloat in
            let yPoint = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            return graphHeight + topBorder - yPoint
        }

        UIColor.systemYellow.setFill()
        UIColor.systemYellow.setStroke()

        let graphPath = UIBezierPath()
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))

        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            graphPath.addLine(to: nextPoint)
        }

        context.saveGState()

        guard let clippingPath = graphPath.copy() as? UIBezierPath else {
            return
        }

        clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count - 1), y: height))
        clippingPath.addLine(to: CGPoint(x: columnXPoint(0), y: height))
        clippingPath.close()

        clippingPath.addClip()

        context.restoreGState()

        graphPath.lineWidth = 3.0
        graphPath.stroke()

        let linePath = UIBezierPath()

        linePath.move(to: CGPoint(x: margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: topBorder))

        linePath.move(to: CGPoint(x: margin, y: graphHeight / 2 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight / 2 + topBorder))

        linePath.move(to: CGPoint(x: margin, y: height - bottomBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: Constants.colorAlpha)
        color.setStroke()

        linePath.lineWidth = 1.25
        linePath.stroke()
    }
}

