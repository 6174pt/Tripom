//
//  TextOnPathView.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/06/21.
//

//import UIKit

//class TextOnPathView: UIView {
    
//    var text: String = "あいうえおあいうえおあいうえおあいうえお"
//    var font: UIFont = UIFont.systemFont(ofSize: 16)
//    var textColor: UIColor = .red
//    var radius: CGFloat = 100
//    var startAngle: CGFloat = -CGFloat.pi / 2
//    var clockwise: Bool = true
//    
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        
//        guard let context = UIGraphicsGetCurrentContext() else { return }
//        
////        let center = CGPoint(x: rect.midX, y: rect.midY)
//        let center = self.center
//        let characters = Array(text)
//        let angleIncrement = (clockwise ? 1 : -1) * (2 * CGFloat.pi / CGFloat(characters.count))
//        
//        for (index, char) in characters.enumerated() {
//            print(char)
//            let angle = startAngle + CGFloat(index) * angleIncrement
//            let x = center.x + radius * cos(angle)
//            let y = center.y + radius * sin(angle)
//            
//            let charString = String(char)
//            let charSize = charString.size(withAttributes: [NSAttributedString.Key.font: font])
//            let charRect = CGRect(x: x - charSize.width / 2, y: y - charSize.height / 2, width: charSize.width, height: charSize.height)
//            
//            context.saveGState()
//            context.translateBy(x: x, y: y)
//            context.rotate(by: angle + (clockwise ? CGFloat.pi / 2 : -CGFloat.pi / 2))
//            charString.draw(in: charRect, withAttributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor])
//            context.restoreGState()
//        }
//    }
    
//}

import UIKit

class TextOnPathView: UIView {
    
    var text = "興奮的な旅を始めましょう！".uppercased()
    var textWidth: Double = 8
    var diameter: Double = 300
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = diameter / 2
        let characters = Array(text)
        
        for (index, letter) in characters.enumerated() {
            let startAngle = textWidth * (Double(text.count) - 1) / 2.0
            let angle = (-startAngle + textWidth * Double(index)) * .pi / 180 - (.pi / 2)
            let x = center.x + radius * cos(CGFloat(angle))
            let y = center.y + radius * sin(CGFloat(angle))
            
            let charString = String(letter)
            let charSize = charString.size(withAttributes: [
                NSAttributedString.Key.font: UIFont.monospacedSystemFont(ofSize: 18, weight: .bold)
            ])
            let charRect = CGRect(x: -charSize.width / 2, y: -charSize.height / 2, width: charSize.width, height: charSize.height)
            
            context.saveGState()
            context.translateBy(x: x, y: y)
            context.rotate(by: CGFloat(angle) + .pi / 2)
            charString.draw(in: charRect, withAttributes: [
                NSAttributedString.Key.font: UIFont.monospacedSystemFont(ofSize: 18, weight: .bold),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ])
            context.restoreGState()
        }
    }
}

