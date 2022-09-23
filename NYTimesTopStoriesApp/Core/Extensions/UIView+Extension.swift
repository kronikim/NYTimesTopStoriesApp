//
//  UIView+Extension.swift
//  NYTTopStoriesApp
//
//  Created by deniz karahan on 18.09.2022.
//

import UIKit

extension UIView {
    func setBorder(color: UIColor, width: CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }

    func setRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
}
