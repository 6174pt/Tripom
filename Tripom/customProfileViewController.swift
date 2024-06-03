//
//  customProfileViewController.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/06/03.
//

import UIKit

class CustomView: UIView {
    var iconImageSize: CGFloat = 50.0 // Adjust this value as needed

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.size.width / 2, y: 150), radius: iconImageSize / 2 + 10, startAngle: -(.pi / 2), endAngle: .pi / 2 * 3, clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.lineWidth = 5
        shapeLayer.strokeColor = UIColor(red: 242 / 255, green: 223 / 255, blue: 154 / 255, alpha: 1.0).cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1.0
        shapeLayer.lineCap = .round
        
        if let context = UIGraphicsGetCurrentContext() {
            context.addPath(circlePath.cgPath)
            context.setStrokeColor(UIColor(red: 242 / 255, green: 223 / 255, blue: 154 / 255, alpha: 1.0).cgColor)
            context.setLineWidth(5)
            context.strokePath()
        }
    }
}
