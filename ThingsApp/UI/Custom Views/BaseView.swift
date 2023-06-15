//
//  BaseView.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 6.6.23..
//

import UIKit

enum LayerShapePositon {
    case footerLeft
    case footerRight
    case headerLeft
}

class BaseView: UIView {

    public var layerShapePosition: LayerShapePositon = .headerLeft

    override func draw(_ rect: CGRect) {
        let frame = self.frame
        let path = UIBezierPath()

        switch layerShapePosition {
        case .footerLeft:
            path.move(to: CGPoint(x: frame.width + 40, y: frame.height))
            path.addQuadCurve(to: CGPoint(x: 0, y: 10), controlPoint: CGPoint(x: (frame.width / 2) + 20, y: -40))
            path.addLine(to: CGPoint(x: 0, y: frame.height))
        case .footerRight:
            path.move(to: CGPoint(x: 20, y: frame.height))
            path.addQuadCurve(to: CGPoint(x: frame.width, y: 10), controlPoint: CGPoint(x: frame.width / 2.5 , y: -40))
            path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        case .headerLeft:
            path.move(to: CGPoint(x: frame.width - 30, y: 0))
            path.addQuadCurve(to: CGPoint(x: 0, y: frame.height), controlPoint: CGPoint(x: frame.width / 2 , y: frame.height + 40 ))
            path.addLine(to: CGPoint(x: 0, y: 0))
        }

        path.close()

        let layerShape = CAShapeLayer()
        layerShape.path = path.cgPath
        layerShape.fillColor =  UIColor.primaryGreen().cgColor
        layer.insertSublayer(layerShape,at:0)
    }


    override func layoutSubviews() {

    }

}
