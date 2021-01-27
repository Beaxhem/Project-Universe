//
//  UIColor.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//

import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        func random() -> CGFloat { return .random(in:0...1) }

        return UIColor(red:   random(),
                       green: random(),
                       blue:  random(),
                       alpha: 0.2)
    }
}
