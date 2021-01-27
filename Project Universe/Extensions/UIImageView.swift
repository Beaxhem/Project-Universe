//
//  UIImageView.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//

import UIKit

extension UIImageView {
    func setImageColor(_ color: UIColor) {
        let template = image?.withRenderingMode(.alwaysTemplate)
        self.image = template
        tintColor = color
    }
}
